# Benchmark results data

Canonical benchmark runs for context projection. See
[`../../docs/RESULTS.md`](../../docs/RESULTS.md) for the full write-up and
[`../../README.md`](../../README.md#results) for the headline table.

## Files

| file | model | projection | notes |
|------|-------|:----------:|-------|
| `gemma4_projection.jsonl` | `gemma4:latest` (local Ollama) | ✅ | no prompt cache; 20/31 |
| `haiku_baseline.jsonl` | Claude Haiku 4.5 | ✗ | full growing transcript; 30/31 |
| `haiku_projection_uncached.jsonl` | Claude Haiku 4.5 | ✅ | pre cache-aware breakpoints; 31/31 |
| `haiku_projection.jsonl` | Claude Haiku 4.5 | ✅ | cache-aware; 31/31 |
| `summary.json` | — | — | machine-readable rollup of all of the above |

## Record schema (`*.jsonl`, one object per task)

Each line is one task result written by `scripts/run_suite.py`:

| field | meaning |
|-------|---------|
| `task_id`, `source` | task identity (e.g. `t4_btree`, `synaxi-T4`) |
| `condition` | `claude-code` (projection) or `claude-code-baseline` |
| `model`, `provider` | model tag and execution path |
| `passed` | did the task's pytest validation pass |
| `complexity`, `category` | tier (`T2`/`T3`/`T4`) and `code/{debug,generation,refactor}` |
| `turns`, `tool_calls` | agent loop length |
| `input_tokens`, `output_tokens` | naive counters (⚠️ hide cache tokens — use the artifact usage) |
| `elapsed_s` | wall-clock seconds |
| `conversation_log_path` | absolute path to the full per-task artifact |
| `conversation_log_file` | artifact filename (resolved under `data/conversation_history/claude_code/`) |

The **honest** token cost (fresh input + cache write + cache read) is *not* in
the naive `input_tokens`; it is summed from each task's artifact `proxy_entries`
usage by `scripts/analyze_results.py`. `summary.json` carries that computed
breakdown per run and per task, so the results are verifiable without shipping
the (large) raw transcripts.

## Regenerate

```bash
python scripts/analyze_results.py data/results/*.jsonl --json data/results/summary.json
```
