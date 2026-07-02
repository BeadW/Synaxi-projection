#!/usr/bin/env python3
"""Analyze one or more projection benchmark suite runs.

A "suite run" is a JSONL file produced by ``scripts/run_suite.py`` (one record
per task). Each record points to its own per-task artifact via
``conversation_log_path``; that artifact contains ``proxy_entries`` — the full
sequence of projected requests and upstream responses, each with the Anthropic
``usage`` block. From those we compute the *honest* token cost, which the naive
``input_tokens`` counter hides whenever prompt caching is in play.

Metrics per run
---------------
* pass rate (overall, by complexity tier, by category)
* turns (total, average)
* wall time (sum of per-task ``elapsed_s``)
* token breakdown, summed over every turn of every task:
    - fresh input        (billed 1x)
    - cache WRITE        (billed 1.25x for 5-minute, 2x for 1-hour ephemeral)
    - cache READ         (billed 0.1x)
    - output
    - context   = input + cache_write + cache_read   (what the model processed)
    - billed_in = 1*input + 1.25*cc5m + 2*cc1h + 0.1*read   (effective $ input)
* cache-hit ratio = read / (write + read)

Usage
-----
    # summarize specific runs
    python scripts/analyze_results.py data/results/*.jsonl

    # summarize + write a machine-readable summary
    python scripts/analyze_results.py data/results/*.jsonl --json data/results/summary.json

    # head-to-head per-task diff between exactly two runs
    python scripts/analyze_results.py runA.jsonl runB.jsonl --compare
"""
from __future__ import annotations

import argparse
import json
import os
import sys
from collections import defaultdict
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]

# Anthropic prompt-caching price multipliers, relative to base input tokens.
PRICE_INPUT = 1.0
PRICE_CACHE_WRITE_5M = 1.25
PRICE_CACHE_WRITE_1H = 2.0
PRICE_CACHE_READ = 0.1


# --------------------------------------------------------------------------- #
# Loading
# --------------------------------------------------------------------------- #
def load_suite(path: Path) -> list[dict]:
    rows = []
    with path.open() as f:
        for line in f:
            line = line.strip()
            if line:
                rows.append(json.loads(line))
    return rows


def _artifact_path(rec: dict) -> Path | None:
    p = rec.get("conversation_log_path")
    if p and os.path.exists(p):
        return Path(p)
    # Fall back to resolving the bare filename under the repo.
    fn = rec.get("conversation_log_file")
    if fn:
        cand = REPO_ROOT / "data" / "conversation_history" / "claude_code" / fn
        if cand.exists():
            return cand
    return None


def _turn_usage(entry: dict) -> dict:
    return ((entry.get("response") or {}).get("usage")) or {}


def token_breakdown(rec: dict) -> dict:
    """Sum the per-turn token usage for one task from its artifact."""
    t = defaultdict(float)
    art = _artifact_path(rec)
    if art is None:
        return t
    try:
        d = json.loads(art.read_text())
    except Exception:
        return t
    for entry in d.get("proxy_entries") or []:
        u = _turn_usage(entry)
        i = u.get("input_tokens", 0) or 0
        cc = u.get("cache_creation_input_tokens", 0) or 0
        cr = u.get("cache_read_input_tokens", 0) or 0
        o = u.get("output_tokens", 0) or 0
        ccd = u.get("cache_creation") or {}
        cc5 = ccd.get("ephemeral_5m_input_tokens", 0) or 0
        cc1h = ccd.get("ephemeral_1h_input_tokens", 0) or 0
        # If the split isn't reported, treat all cache-write as 5-minute.
        if not (cc5 or cc1h):
            cc5 = cc
        t["input"] += i
        t["cache_write"] += cc
        t["cache_read"] += cr
        t["output"] += o
        t["cc5"] += cc5
        t["cc1h"] += cc1h
    t["context"] = t["input"] + t["cache_write"] + t["cache_read"]
    t["billed_in"] = (PRICE_INPUT * t["input"]
                      + PRICE_CACHE_WRITE_5M * t["cc5"]
                      + PRICE_CACHE_WRITE_1H * t["cc1h"]
                      + PRICE_CACHE_READ * t["cache_read"])
    return t


# --------------------------------------------------------------------------- #
# Summarize
# --------------------------------------------------------------------------- #
def summarize(path: Path) -> dict:
    rows = load_suite(path)
    total = len(rows)
    passed = sum(1 for r in rows if r.get("passed"))

    by_tier = defaultdict(lambda: [0, 0])       # tier -> [passed, total]
    by_cat = defaultdict(lambda: [0, 0])
    tok = defaultdict(float)
    turns = 0
    wall = 0.0
    per_task = {}

    for r in rows:
        tier = r.get("complexity") or "?"
        cat = r.get("category") or "?"
        ok = bool(r.get("passed"))
        by_tier[tier][1] += 1
        by_tier[tier][0] += ok
        by_cat[cat][1] += 1
        by_cat[cat][0] += ok
        turns += r.get("turns", 0) or 0
        wall += r.get("elapsed_s", 0) or 0
        tb = token_breakdown(r)
        for k, v in tb.items():
            tok[k] += v
        per_task[r["task_id"]] = {
            "passed": ok, "tier": tier, "category": cat,
            "turns": r.get("turns", 0), "elapsed_s": r.get("elapsed_s", 0),
            "context": tb.get("context", 0.0), "billed_in": tb.get("billed_in", 0.0),
        }

    model = rows[0].get("model") if rows else "?"
    condition = rows[0].get("condition") if rows else "?"
    cw, cr = tok["cache_write"], tok["cache_read"]
    cache_hit = (cr / (cw + cr) * 100.0) if (cw + cr) else 0.0

    return {
        "file": path.name,
        "model": model,
        "condition": condition,
        "tasks": total,
        "passed": passed,
        "pass_rate": (passed / total * 100.0) if total else 0.0,
        "by_tier": {k: v for k, v in sorted(by_tier.items())},
        "by_category": {k: v for k, v in sorted(by_cat.items())},
        "turns_total": turns,
        "turns_avg": (turns / total) if total else 0.0,
        "wall_s": wall,
        "tokens": {
            "input": tok["input"],
            "cache_write": tok["cache_write"],
            "cache_read": tok["cache_read"],
            "output": tok["output"],
            "context": tok["context"],
            "billed_in": tok["billed_in"],
        },
        "cache_hit_pct": cache_hit,
        "per_task": per_task,
    }


def _fmt(n) -> str:
    return f"{int(round(n)):,}"


def print_summary(s: dict) -> None:
    print("=" * 78)
    print(f"{s['condition']}  /  model={s['model']}")
    print(f"  file: {s['file']}")
    print("-" * 78)
    print(f"  PASS RATE:  {s['passed']}/{s['tasks']}  ({s['pass_rate']:.0f}%)")
    tiers = "   ".join(f"{k} {v[0]}/{v[1]}" for k, v in s["by_tier"].items())
    print(f"    by tier:      {tiers}")
    cats = "   ".join(f"{k} {v[0]}/{v[1]}" for k, v in s["by_category"].items())
    print(f"    by category:  {cats}")
    print(f"  turns: {s['turns_total']} total ({s['turns_avg']:.1f} avg)   "
          f"wall: {s['wall_s']/60:.1f} min")
    tk = s["tokens"]
    if tk["context"]:
        print("  tokens:")
        print(f"    fresh input:  {_fmt(tk['input']):>14}")
        print(f"    cache WRITE:  {_fmt(tk['cache_write']):>14}   (1.25-2x)")
        print(f"    cache READ:   {_fmt(tk['cache_read']):>14}   (0.1x)")
        print(f"    output:       {_fmt(tk['output']):>14}")
        print(f"    ── context:   {_fmt(tk['context']):>14}   (total processed)")
        print(f"    ── billed in: {_fmt(tk['billed_in']):>14}   (effective $ input)")
        print(f"    cache-hit:    {s['cache_hit_pct']:>13.0f}%")
    print()


def print_compare(sA: dict, sB: dict) -> None:
    print("=" * 96)
    print(f"HEAD-TO-HEAD   A={sA['condition']}/{sA['model']}   vs   "
          f"B={sB['condition']}/{sB['model']}")
    print("=" * 96)
    ids = list(sA["per_task"]) + [t for t in sB["per_task"] if t not in sA["per_task"]]
    hdr = (f"{'task':<26}{'tier':<5}"
           f"{'A pass':>7}{'A ctx':>12}{'A bill':>11}"
           f"{'B pass':>8}{'B ctx':>13}{'B bill':>11}{'ctx x':>8}")
    print(hdr)
    print("-" * len(hdr))
    for tid in ids:
        a = sA["per_task"].get(tid)
        b = sB["per_task"].get(tid)
        tier = (a or b or {}).get("tier", "?")
        ap = ("PASS" if a["passed"] else "FAIL") if a else "-"
        bp = ("PASS" if b["passed"] else "FAIL") if b else "-"
        actx = _fmt(a["context"]) if a else "-"
        bctx = _fmt(b["context"]) if b else "-"
        abill = _fmt(a["billed_in"]) if a else "-"
        bbill = _fmt(b["billed_in"]) if b else "-"
        ratio = (f"{b['context']/a['context']:.1f}x"
                 if (a and b and a["context"]) else "-")
        print(f"{tid:<26}{tier:<5}{ap:>7}{actx:>12}{abill:>11}"
              f"{bp:>8}{bctx:>13}{bbill:>11}{ratio:>8}")
    print("-" * len(hdr))
    ta, tb = sA["tokens"], sB["tokens"]
    print(f"TOTALS   context:  A={_fmt(ta['context'])}  B={_fmt(tb['context'])}"
          f"   billed_in:  A={_fmt(ta['billed_in'])}  B={_fmt(tb['billed_in'])}")
    print(f"         pass:     A={sA['passed']}/{sA['tasks']}  B={sB['passed']}/{sB['tasks']}"
          f"   cache-hit: A={sA['cache_hit_pct']:.0f}%  B={sB['cache_hit_pct']:.0f}%")


def main() -> None:
    ap = argparse.ArgumentParser(description="Analyze projection benchmark suite runs.")
    ap.add_argument("suites", nargs="+", help="One or more suite_*.jsonl files.")
    ap.add_argument("--json", dest="json_out", default=None,
                    help="Write a machine-readable summary of all runs to this path.")
    ap.add_argument("--compare", action="store_true",
                    help="Print a per-task head-to-head diff (requires exactly 2 suites).")
    args = ap.parse_args()

    summaries = [summarize(Path(p)) for p in args.suites]
    for s in summaries:
        print_summary(s)

    if args.compare:
        if len(summaries) != 2:
            print("--compare requires exactly two suite files.", file=sys.stderr)
            sys.exit(2)
        print_compare(summaries[0], summaries[1])

    if args.json_out:
        # Keep the full per-task breakdown so the summary is self-contained and
        # verifiable without the (bulky) raw transcripts.
        Path(args.json_out).write_text(json.dumps(summaries, indent=2))
        print(f"\nwrote {args.json_out}")


if __name__ == "__main__":
    main()
