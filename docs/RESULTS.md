# Results

Benchmark results for **context projection** on a 31-task coding suite
(10 × T2, 12 × T3, 9 × T4; categories: debug, generation, refactor).

All runs use the **same measurement path** — `claude -p` → the projection proxy
→ a model — so the only thing that changes between runs is the model and whether
projection is applied. Raw run files and a machine-readable summary live in
[`../data/results/`](../data/results/); regenerate every number here with:

```bash
python scripts/analyze_results.py data/results/*.jsonl --json data/results/summary.json
```

## The runs

| # | file | model | projection | prompt cache |
|---|------|-------|:----------:|:------------:|
| 1 | `gemma4_projection.jsonl` | `gemma4:latest` (local Ollama) | ✅ | ✗ (Ollama has none) |
| 2 | `haiku_baseline.jsonl` | Claude Haiku 4.5 | ✗ (full growing transcript) | ✅ |
| 3 | `haiku_projection_uncached.jsonl` | Claude Haiku 4.5 | ✅ (no cache breakpoints) | partial |
| 4 | `haiku_projection.jsonl` | Claude Haiku 4.5 | ✅ (cache-aware) | ✅ |

## Headline numbers

| metric | ① gemma4 + proj | ② Haiku baseline | ④ Haiku + proj (cache-aware) |
|---|---:|---:|---:|
| **pass rate** | 20/31 (65%) | 30/31 (97%) | **31/31 (100%)** |
| turns (total / avg) | 773 / 24.9 | 460 / 14.8 | 816 / 26.3 |
| wall time | 499.4 min | 42.6 min | 47.3 min |
| fresh input tokens | 2,383,884 | 7,572 | 528,936 |
| cache write (1.25–2×) | 0 | 521,073 | 585,890 |
| cache read (0.1×) | 0 | 18,467,591 | 6,326,236 |
| **raw context processed** | 2,383,884 | 18,996,236 | **7,441,062** |
| **effective billed input** | 2,383,884 | 2,896,477 | **1,893,922** |
| cache-hit ratio | 0% | 97% | 92% |
| output tokens | 561,927 | 231,108 | 238,395 |

> "Raw context processed" = `input + cache_write + cache_read` — the tokens the
> model actually had to look at each turn. "Effective billed input" weights those
> by Anthropic's cache pricing (`1× input`, `1.25×`/`2×` cache write, `0.1×`
> cache read) — the honest cost the naive `input_tokens` counter hides.

## What the numbers say

### 1. Projection vs. the growing baseline (Haiku, ④ vs ②)

Projection beats the traditional growing-transcript baseline on **both** axes,
while matching quality:

- **Quality:** 31/31 vs 30/31 (baseline's one miss was `t3_diff_engine`).
- **Raw context:** **2.6× less** (7.44M vs 19.0M).
- **Billed input:** **1.53× cheaper** (1.89M vs 2.90M) — *even against a
  caching-enabled frontier model.*

The cost win is the interesting part, because the baseline is exactly the case
prompt-caching was designed for: a stable, ever-growing prefix that caches at
97% and re-reads at 0.1×. Projection still wins on cost because it pushes far
less raw context through the model in the first place.

### 2. Caching is not automatic — you have to earn it (④ vs ③)

Our **first** cache-aware attempt (③) actually **lost** on billed input:

| | ③ projection, no breakpoints | ④ projection, cache-aware |
|---|---:|---:|
| billed input | 3,423,795 | **1,893,922** |
| cache-hit | 85% | **92%** |
| raw context | 8,176,934 | 7,441,062 |

Same engine, same tasks — the **only** change was *where the cache breakpoints
sit*. Projection rebuilds the message array every turn; if the single inherited
`cache_control` marker sits on the **volatile** last message, Anthropic is forced
to re-write almost the whole prefix each turn. Moving explicit breakpoints onto
the **byte-stable** segments (system prompt, tool list, and the append-only world
observations) — and relocating volatile operational-memory to the tail — let the
stable prefix cache and re-read at 0.1×, cutting billed input **1.8×**.

This is the same incremental-caching shape Claude Code uses on itself; projection
just had to reproduce it. See `scripts/_test_prefix_stable.py` for the
byte-stability proof and `scripts/_test_cache_aware.py` for the breakpoint
placement test.

### 3. Projection makes small local models viable at all (①)

Run ① is the original motivation: `gemma4:latest` on a laptop, no caching. It
solved **20/31 (65%)** — including 8/10 T2 and 10/12 T3 — through the projection
proxy. Without projection, the growing transcript (≈10 KB system + ~60 tool
schemas + every turn) overruns a 7-8B model's usable context and it loops. The
tradeoff is speed: local wall time is ~10× the hosted model's.

## Honest caveats

- **Turns:** projection takes **1.8× more turns** than the baseline (816 vs 460).
  Compressing history means the agent occasionally re-derives state it had
  already established. Net cost still wins, but latency-sensitive uses should
  weigh this.
- **Pathological blow-ups:** on rare long tasks a compressed world can make the
  agent loop (e.g. `t4_btree` in an earlier run ran to 118 turns). The
  token-weighted eviction bounds context, not turn count.
- **Cache-hit ceiling:** projection tops out around 92% (vs the baseline's 97%)
  because its world genuinely grows; it will never be a perfectly frozen prefix.
- **One model, one suite:** these are Haiku 4.5 and gemma4 on 31 tasks. Treat the
  ratios as directional, not universal.

## Reproducing

```bash
# 1. cache-aware projection through real Claude (uses your Claude subscription;
#    do NOT set ANTHROPIC_API_KEY / ANTHROPIC_AUTH_TOKEN — claude -p auths itself)
python scripts/run_suite.py --mode claude-code \
  --upstream https://api.anthropic.com --model haiku --fs-tracker snapshot

# 2. baseline (same path, projection disabled)
python scripts/run_suite.py --mode claude-code --no-projection \
  --upstream https://api.anthropic.com --model haiku --fs-tracker snapshot

# 3. local model through the proxy → Ollama
python scripts/run_suite.py --mode claude-code \
  --upstream http://127.0.0.1:11434 --model gemma4:latest --fs-tracker snapshot

# analyze / compare any two runs
python scripts/analyze_results.py data/results/haiku_projection.jsonl \
                                  data/results/haiku_baseline.jsonl --compare
```
