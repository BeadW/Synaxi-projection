#!/usr/bin/env python3
"""Compact status snapshot for the running projection full-suite benchmark.

Reads the newest suite_*.jsonl results file plus the live proxy session log and
prints a one-shot tally: completion, pass/fail, per-task table, and whether the
in-flight task is actively hitting the proxy (ACTIVE) or has gone quiet (STALE).
Safe to run repeatedly; does not touch the running suite.
"""
import glob
import json
import os
import time
from datetime import datetime

HERE = os.path.dirname(os.path.abspath(__file__))
RUNS_DIR = os.path.join(HERE, "..", "data", "runs")
CONV_DIR = os.path.expanduser("~/.synaxi-projection/conversations")
TOTAL = 31  # tasks in the full suite


def newest(pattern):
    files = sorted(glob.glob(pattern), key=os.path.getmtime, reverse=True)
    return files[0] if files else None


def main():
    suite = newest(os.path.join(RUNS_DIR, "suite_*.jsonl"))
    now = datetime.now().strftime("%H:%M:%S")
    print(f"===== SUITE STATUS  {now} =====")
    if not suite:
        print("no suite results file found")
        return

    rows = [json.loads(line) for line in open(suite) if line.strip()]
    done = len(rows)
    passed = sum(1 for r in rows if r.get("passed"))
    failed = done - passed
    elapsed = [r.get("elapsed_s", 0) or 0 for r in rows]
    avg = sum(elapsed) / done if done else 0
    remaining_min = avg * (TOTAL - done) / 60 if done else 0
    rate = (passed / done * 100) if done else 0

    print(f"file: {os.path.basename(suite)}")
    print(f"completed: {done}/{TOTAL}   PASS={passed}  FAIL={failed}  rate={rate:.0f}%")
    print(f"avg/task: {avg:.0f}s   est remaining: ~{remaining_min:.0f} min")
    print("-" * 60)
    for r in rows:
        mark = "PASS" if r.get("passed") else "FAIL"
        print(
            f"  {r.get('complexity','?'):3} {r.get('category',''):16} "
            f"{r.get('task_id',''):26} {mark} "
            f"turns={r.get('turns')} tools={r.get('tool_calls')} "
            f"{r.get('elapsed_s',0):.0f}s"
        )

    sess = newest(os.path.join(CONV_DIR, "session_*.jsonl"))
    running = _suite_running()
    print("-" * 60)
    if sess and running:
        age = time.time() - os.path.getmtime(sess)
        with open(sess) as f:
            n = sum(1 for _ in f)
        # With stream:False the proxy only logs an exchange once the *full*
        # response lands, so a slow single generation looks "idle". An open
        # ESTABLISHED socket to the proxy port means the model is mid-response.
        if _proxy_inflight():
            status = "GENERATING (model producing response, in-flight)"
        elif age < 300:
            status = "ACTIVE"
        else:
            status = f"STALE ({age:.0f}s idle — possibly stuck)"
        print(f"in-flight: task #{done+1}/{TOTAL}  proxy_exchanges={n}  "
              f"last_hit={age:.0f}s ago  [{status}]")
    elif not running:
        print("suite process: NOT RUNNING (finished or stopped)")


def _proxy_inflight(port=8787):
    """True if there's an ESTABLISHED (non-listening) connection on the proxy port."""
    try:
        out = os.popen(f"lsof -nP -iTCP:{port} 2>/dev/null").read()
        return "ESTABLISHED" in out
    except Exception:
        return False


def _suite_running():
    try:
        out = os.popen("pgrep -f run_suite.py").read().strip()
        return bool(out)
    except Exception:
        return False


if __name__ == "__main__":
    main()
