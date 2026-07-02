#!/usr/bin/env python3
"""
Full-suite benchmark orchestrator for the projection pipeline.

Reuses the orchestration patterns from the original harness runner
(``scripts/run_benchmark.py`` in synaxi-predict) — difficulty interleaving,
resume/skip of completed tasks, dated JSONL recording, and a final summary —
but drives the NEW projection engine instead of the direct-API harness:

  * ``--mode claude-code`` : ``claude -p`` routed through the projection proxy → Ollama
  * ``--mode projection``  : in-process projection agent loop → Ollama
  * ``--mode baseline``    : in-process full-context agent loop → Ollama

For ``claude-code`` mode the projection proxy is started/stopped automatically
(and health-checked + restarted between tasks if it dies).

Usage:
    python scripts/run_suite.py --model gemma4:latest                 # full suite, claude-code
    python scripts/run_suite.py --mode projection --model gemma4:latest
    python scripts/run_suite.py --limit 3 --dry-run
    python scripts/run_suite.py --resume                              # skip already-passed/attempted
    python scripts/run_suite.py --category code/generation
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from collections import Counter, defaultdict
from datetime import datetime, timezone
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT))

from synaxi_projection.benchmark import (  # noqa: E402
    OLLAMA_URL,
    load_synaxi_tasks,
    run_benchmark_task,
    run_benchmark_task_claude_code,
)
from synaxi_projection.proxy import is_proxy_running, start_proxy, stop_proxy  # noqa: E402

RESULTS_FILE = REPO_ROOT / "data" / "benchmark_annotation_results.jsonl"
RUNS_DIR = REPO_ROOT / "data" / "runs"

COMPLEXITY_RANK = {"T1": 0, "T2": 1, "T3": 2, "T4": 3, "Competition": 4}


# --------------------------------------------------------------------------- #
# Task selection / ordering  (reused from the original runner)
# --------------------------------------------------------------------------- #

def _category_of(task: dict) -> str:
    path = task.get("path", "")
    for cat in ("code/generation", "code/debug", "code/refactor"):
        if cat in path:
            return cat
    return "other"


def interleave_by_difficulty(tasks: list[dict]) -> list[dict]:
    """Round-robin across complexity buckets so progress always spans easy→hard."""
    buckets: dict[str, list[dict]] = defaultdict(list)
    for t in tasks:
        buckets[t.get("complexity") or "T1"].append(t)
    order = sorted(buckets, key=lambda c: COMPLEXITY_RANK.get(c, 99))
    result: list[dict] = []
    while any(buckets[c] for c in order):
        for c in order:
            if buckets[c]:
                result.append(buckets[c].pop(0))
    return result


# --------------------------------------------------------------------------- #
# Resume support  (reused idea: skip already-recorded (task, condition, model))
# --------------------------------------------------------------------------- #

def load_completed(condition: str, model: str) -> set[str]:
    """Return task_ids already recorded for this condition+model in the results file."""
    done: set[str] = set()
    if not RESULTS_FILE.exists():
        return done
    for line in RESULTS_FILE.read_text().splitlines():
        if not line.strip():
            continue
        try:
            r = json.loads(line)
        except Exception:
            continue
        if r.get("condition") == condition and r.get("model") == model and r.get("turns", 0) > 0:
            done.add(r.get("task_id"))
    return done


def write_suite_record(record: dict, suite_file: Path) -> None:
    suite_file.parent.mkdir(parents=True, exist_ok=True)
    with suite_file.open("a") as f:
        f.write(json.dumps(record, separators=(",", ":")) + "\n")


# --------------------------------------------------------------------------- #
# Proxy lifecycle (claude-code mode)
# --------------------------------------------------------------------------- #

def _ensure_proxy(proc, port: int, upstream: str, model: str, disable_projection: bool = False):
    """Make sure the projection proxy is alive; (re)start it if not."""
    if is_proxy_running(port):
        return proc
    if proc is not None:
        stop_proxy(proc)
    print(f"  [proxy] starting on :{port} → {upstream} (model={model})", flush=True)
    return start_proxy(port=port, upstream=upstream, model=model, disable_projection=disable_projection)


# --------------------------------------------------------------------------- #
# Main
# --------------------------------------------------------------------------- #

def main() -> None:
    parser = argparse.ArgumentParser(description="Projection full-suite benchmark orchestrator")
    parser.add_argument("--mode", default="claude-code",
                        choices=["claude-code", "projection", "baseline"],
                        help="Execution path (default: claude-code)")
    parser.add_argument("--model", default="gemma4:latest",
                        help="Ollama model tag (default: gemma4:latest)")
    parser.add_argument("--ollama-url", default=OLLAMA_URL,
                        help="Ollama OpenAI-compatible chat endpoint (projection/baseline modes)")
    parser.add_argument("--upstream", default="http://127.0.0.1:11434",
                        help="Ollama base URL the proxy forwards to (claude-code mode)")
    parser.add_argument("--native-auth", action="store_true",
                        help="Use the real Claude subscription: claude -p auths with its "
                             "own stored OAuth creds and the proxy forwards them upstream "
                             "(auto-enabled when --upstream targets api.anthropic.com).")
    parser.add_argument("--no-projection", action="store_true",
                        help="Baseline A/B: run claude -p through the proxy but DISABLE "
                             "projection (forward the full, growing conversation) so you "
                             "can directly compare projection vs no-projection.")
    parser.add_argument("--port", type=int, default=8787, help="Projection proxy port")
    parser.add_argument("--fs-tracker", default="snapshot",
                        choices=["auto", "snapshot", "fuse"],
                        help="Filesystem tracker backend (default: snapshot)")
    parser.add_argument("--require-fuse", action="store_true")
    parser.add_argument("--run-timeout", type=int, default=1800,
                        help="Per-task wall-clock timeout in seconds (default: 1800 = 30 min). "
                             "Generous on purpose: local models on a laptop are slow (~30-40s/turn), "
                             "so a hard multi-turn task legitimately needs many minutes. Only bump "
                             "DOWN if a task is clearly stuck/looping.")
    parser.add_argument("--validation-timeout", type=int, default=120,
                        help="pytest/validation timeout in seconds (default: 120)")
    parser.add_argument("--category", default=None,
                        help="Filter tasks by category substring (e.g. code/generation)")
    parser.add_argument("--complexity", default=None,
                        help="Filter by complexity tier (e.g. T2)")
    parser.add_argument("--limit", type=int, default=None)
    parser.add_argument("--no-interleave", action="store_true")
    parser.add_argument("--resume", action="store_true",
                        help="Skip tasks already recorded for this condition+model")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    mode = args.mode
    native_auth = args.native_auth or ("anthropic.com" in args.upstream)
    no_projection = args.no_projection
    # `condition` is only a label (suite filename / resume key / record).
    # Code paths branch on `mode`; baseline just gets a distinct label so
    # its records + transcripts don't collide with the projection run.
    condition = mode + ("-baseline" if (mode == "claude-code" and no_projection) else "")

    tasks = load_synaxi_tasks(REPO_ROOT)
    if args.category:
        tasks = [t for t in tasks if args.category in _category_of(t)]
    if args.complexity:
        tasks = [t for t in tasks if (t.get("complexity") or "") == args.complexity]
    if not tasks:
        print("No tasks matched the filters.")
        sys.exit(1)

    tasks = tasks if args.no_interleave else interleave_by_difficulty(tasks)
    if args.limit:
        tasks = tasks[: args.limit]

    completed = load_completed(condition, args.model) if args.resume else set()
    if completed:
        tasks = [t for t in tasks if t["id"] not in completed]

    ts = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    suite_file = RUNS_DIR / f"suite_{condition}_{args.model.replace(':', '_')}_{ts}.jsonl"

    print("=" * 70)
    print("PROJECTION FULL-SUITE BENCHMARK")
    print(f"  mode={condition}  model={args.model}  fs_tracker={args.fs_tracker}")
    print(f"  tasks={len(tasks)}  run_timeout={args.run_timeout}s  resume={args.resume}")
    if mode == "claude-code":
        dest = args.upstream if native_auth else f"{args.upstream} (ollama, model rewrite -> {args.model})"
        print(f"  upstream={dest}  native_auth={native_auth}  projection={not no_projection}")
    if completed:
        print(f"  skipping {len(completed)} already-recorded task(s)")
    print(f"  suite log: {suite_file}")
    print("=" * 70)

    by_cx = Counter(t.get("complexity") for t in tasks)
    by_cat = Counter(_category_of(t) for t in tasks)
    print("  by complexity:", dict(sorted(by_cx.items())))
    print("  by category:  ", dict(sorted(by_cat.items())))
    print()

    if args.dry_run:
        for i, t in enumerate(tasks, 1):
            print(f"  [{i:2d}/{len(tasks)}] {t['complexity']:>3}  {_category_of(t):<16} {t['id']}")
        print("\n[dry-run] no tasks executed.")
        return

    proxy_proc = None
    results: list[dict] = []
    t_start = time.time()
    try:
        for i, task in enumerate(tasks, 1):
            cat = _category_of(task)
            print(f"[{i}/{len(tasks)}] {task['complexity']:>3} {cat:<16} {task['id']}", flush=True)
            print(f"    task: {task['task'][:72]}", flush=True)
            print("    → running...", end="", flush=True)

            try:
                if mode == "claude-code":
                    proxy_proc = _ensure_proxy(proxy_proc, args.port, args.upstream, args.model, disable_projection=no_projection)
                    r = run_benchmark_task_claude_code(
                        task,
                        model=args.model,
                        proxy_url=f"http://127.0.0.1:{args.port}",
                        fs_tracker_mode=args.fs_tracker,
                        require_fuse=args.require_fuse,
                        run_timeout=args.run_timeout,
                        validation_timeout=args.validation_timeout,
                        condition=condition,
                        native_auth=native_auth,
                    )
                else:
                    r = run_benchmark_task(
                        task, args.model, use_annotation=False,
                        projection=(mode == "projection"),
                        provider="ollama",
                        ollama_url=args.ollama_url,
                        provider_timeout=600,
                        run_timeout=args.run_timeout,
                        fs_tracker_mode=args.fs_tracker,
                        require_fuse=args.require_fuse,
                        validation_timeout=args.validation_timeout,
                        condition=condition,
                    )
            except Exception as e:
                print(f" ERROR: {e}", flush=True)
                r = {
                    "task_id": task["id"], "source": task["source"],
                    "condition": condition, "passed": False, "model": args.model,
                    "turns": 0, "tool_calls": 0, "input_tokens": 0, "output_tokens": 0,
                    "cost_usd": 0, "elapsed_s": 0, "error": str(e),
                }

            r["complexity"] = task.get("complexity")
            r["category"] = cat
            mark = "\033[92mPASS\033[0m" if r.get("passed") else "\033[91mFAIL\033[0m"
            print(f" {mark} | turns={r.get('turns', 0)} tools={r.get('tool_calls', 0)} "
                  f"{r.get('elapsed_s', 0)}s", flush=True)
            if r.get("conversation_log_file"):
                print(f"    history: {r['conversation_log_file']}", flush=True)
            if not r.get("passed") and r.get("pytest_output"):
                print(f"    pytest: {str(r['pytest_output'])[:120]!r}", flush=True)

            results.append(r)
            write_suite_record(r, suite_file)
            # also append to the canonical results file for cross-run resume/analysis
            with RESULTS_FILE.open("a") as f:
                f.write(json.dumps(r) + "\n")
    finally:
        if proxy_proc is not None:
            stop_proxy(proxy_proc)

    # ---- summary ----
    elapsed = round(time.time() - t_start, 1)
    print("\n" + "=" * 70)
    print("RESULTS SUMMARY")
    print("=" * 70)
    n = len(results)
    npass = sum(1 for r in results if r.get("passed"))
    print(f"  Overall: {npass}/{n} ({round(npass / n * 100) if n else 0}%)  in {elapsed}s")

    print("\n  By complexity:")
    for cx in sorted({r.get("complexity") for r in results}, key=lambda c: COMPLEXITY_RANK.get(c, 99)):
        sub = [r for r in results if r.get("complexity") == cx]
        p = sum(1 for r in sub if r.get("passed"))
        print(f"    {cx or '?':>4}  {p}/{len(sub)} ({round(p / len(sub) * 100) if sub else 0}%)")

    print("\n  By category:")
    for cat in sorted({r.get("category") for r in results}):
        sub = [r for r in results if r.get("category") == cat]
        p = sum(1 for r in sub if r.get("passed"))
        print(f"    {cat:<16} {p}/{len(sub)} ({round(p / len(sub) * 100) if sub else 0}%)")

    tot_in = sum(r.get("input_tokens", 0) for r in results)
    tot_out = sum(r.get("output_tokens", 0) for r in results)
    avg_turns = (sum(r.get("turns", 0) for r in results) / n) if n else 0
    print(f"\n  Avg turns: {avg_turns:.1f}   tokens in/out: {tot_in}/{tot_out}")
    print(f"  Suite log: {suite_file}")
    print("  Failures:  " + (", ".join(r["task_id"] for r in results if not r.get("passed")) or "none"))


if __name__ == "__main__":
    main()
