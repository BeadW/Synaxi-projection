# synaxi-projection

Projection-only context tooling, separated from `synaxi-predict`.

This repository is the runtime + benchmark harness used to evaluate **context
projection**: shrinking a coding agent's ever-growing transcript down to a
small, *constant-space* context that a local model can actually run, **without
losing the agent's working memory**.

It can drive two execution paths against the same projection engine:

1. **In-process agent loop** (`benchmark.py`) — the harness owns the loop and
   executes tools itself, against a sandbox observed through a **FUSE**
   filesystem.
2. **Claude Code via a MITM proxy** (`_proxy_server.py`) — Claude Code owns the
   loop; a local proxy projects every request before it reaches a local Ollama
   model.

---

## Quick start

Projection runs as a small local proxy between **Claude Code** (the `claude`
CLI) and whichever model serves it. You use Claude Code exactly as you normally
would; the proxy transparently rewrites each request into a compact,
constant-space context before it goes upstream.

**Prerequisites**

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed and on
  your `PATH` — check with `which claude`.
- This package installed:

  ```bash
  pip install -e .
  ```

### 1. Your normal Claude session — with projection

Run against your real Claude subscription and the usual Claude models; the only
difference is that projection shrinks the context on the way out (and adds
prompt caching). `claude` authenticates itself, so **do not** set
`ANTHROPIC_API_KEY` or `ANTHROPIC_AUTH_TOKEN`.

```bash
synaxi-projection wrap claude
```

That's the whole thing. The proxy starts pointed at `https://api.anthropic.com`
(the default), every Claude Code request is projected, and your normal `claude`
session launches. Anything after `claude` is passed straight through to Claude
Code. When you exit, the proxy stops and your settings are restored.

### 2. A fully local session (Ollama) — with projection

Point the same wrapper at a local [Ollama](https://ollama.com) server (v0.14.0+,
which speaks the Anthropic Messages API natively). This is what makes a small
model usable as a coding agent at all: projection keeps the transcript from
overrunning its context window.

```bash
# once: pull a coding model
ollama pull qwen2.5-coder:7b

# route Claude Code through projection → Ollama
synaxi-projection wrap claude \
  --upstream http://127.0.0.1:11434 \
  --model qwen2.5-coder:7b
```

The wrapper supplies a throwaway auth token (Ollama ignores it) and forwards
your chosen `--model` upstream.

### Manage the wrapper

```bash
synaxi-projection status          # wrapped? proxy up?
synaxi-projection doctor          # health checks (claude on PATH, proxy reachable, …)
synaxi-projection unwrap claude   # restore .claude/settings.local.json and stop the proxy
```

> The wrapper writes `ANTHROPIC_BASE_URL` into `.claude/settings.local.json` so
> every Claude Code session (including daemon-spawned workers) routes through the
> proxy, then restores it on exit. Keep `~/.local/bin` earlier on your `PATH`
> than any other `claude` install.

---

## Results

On a 31-task coding suite (10×T2, 12×T3, 9×T4), driven through the **same**
`claude -p` → proxy → model path so projection is the only variable:

| metric | gemma4 + projection (local) | Haiku baseline (growing) | **Haiku + projection (cache-aware)** |
|---|---:|---:|---:|
| **pass rate** | 20/31 (65%) | 30/31 (97%) | **31/31 (100%)** |
| **raw context processed** | 2.38M | 19.0M | **7.44M** |
| **effective billed input** | 2.38M | 2.90M | **1.89M** |
| cache-hit ratio | 0% (no cache) | 97% | 92% |

**Against a caching-enabled frontier model, projection beats the traditional
growing transcript on both raw context (2.6× less) and real billed cost
(1.53× cheaper) — while matching quality (31/31 vs 30/31).** It also makes an
8B local model (`gemma4`) viable at all: 65% on the same suite where the raw
transcript would overrun its context and loop.

Getting the cost win required making projection **cache-aware**: because
projection rebuilds the message array each turn, the cache breakpoints must sit
on the *byte-stable* segments (system, tools, append-only world) rather than the
volatile tail. Doing so cut billed input 1.8× (3.42M → 1.89M) with no other
change. Full write-up, caveats, and reproduction steps in
**[`docs/RESULTS.md`](docs/RESULTS.md)**; raw runs in
[`data/results/`](data/results/).

---

## Why projection exists (the loop bug it prevents)

A coding agent's transcript grows without bound: a ~10 KB system prompt, ~60
tool schemas, and every prior `tool_use` / `tool_result` turn. A frontier model
tolerates this; a 7B local model drowns in it.

The naive fix — "just keep the last turn" — is **worse than useless**. If
projection collapses history to a single tool pair and drops command output,
the agent never sees the result of its last action and **loops forever**:

```
turn 2:  ls            -> "test_event_emitter.py"   -> model decides to read it
turn 3:  ls (again)    -> "test_event_emitter.py"   -> model decides to read it
turn 4:  ls (again)    -> ...                         (the read result was dropped)
```

Correct projection keeps the **full progression** of durable observations, each
re-emitted as a *valid, correctly-paired* `tool_use` / `tool_result` exchange,
so the model always sees what actually happened and moves forward.

---

## How the projection context is built

All projection logic lives in **`synaxi_projection/projection.py`** — the single
source of truth shared by the benchmark loop, the proxy, and `proxy.py`.

The context is rebuilt from three ingredients every turn:

### 1. The `WorldCache` — durable observations as native tool pairs

The `WorldCache` is a token-weighted store of everything the agent has durably
observed, keyed by identity:

| Observation        | Key            | Value                          |
| ------------------ | -------------- | ------------------------------ |
| File read          | `path`         | file contents                  |
| File written/edited| `path`         | new contents                   |
| Command run        | `cmd:<command>`| stdout + stderr (`ls`, `pytest`)|

`generate_context()` then **replays each entry as a real message pair**, not as
a prose summary:

```
user:       <goal> + <operational_memory>
assistant:  tool_use   Bash(ls -F)          (synthetic id syn_…)
user:       tool_result "test_event_emitter.py"
assistant:  tool_use   Read(test_event_emitter.py)
user:       tool_result "import pytest …"
assistant:  tool_use   Bash(python3 -m pytest)
user:       tool_result "exit=1 … ModuleNotFoundError"
assistant:  tool_use   <the real most-recent action>   (verbatim, Claude's id)
user:       tool_result <the real most-recent result>
```

Why native pairs instead of a `<current_files>` blob? Tool-calling models are
trained on the `assistant(tool_use) → user(tool_result)` shape. Re-emitting
observations in that exact shape keeps the model on-distribution, and because
**every** synthesized `tool_use` is immediately followed by its `tool_result`,
the projected payload stays a valid Anthropic Messages request for Ollama's
native endpoint.

The most recent completed tool pair is appended **verbatim** (keeping the
upstream agent's real tool id/name) as the live stimulus the model must react
to; the rest of history is the deduped world above it.

### 2. Token-weighted LRU eviction

The world is bounded (`token_budget = 8000`). On each turn `WorldCache.tick()`
evicts the highest-cost entries first:

```
score = tokens(entry) * turns_since_last_used
```

Large, stale entries (an old file you haven't touched in 10 turns) are evicted
before small, recent ones (the `ls` output you keep relying on).

### 3. `ProjectionControlState` — operational memory

Repeated tool failures are distilled into a short `<operational_memory>` block
that rides along in the goal message, e.g.:

- `python: command not found` → "Use `python3` (not `python`) in this sandbox."
- reading a directory as a file → "use `run_command` (`ls`/`find`) for discovery."
- the same path failing twice → "list files first, then read exact paths."

This is how the agent *learns within a run* without re-deriving the same lesson
every turn.

### The system prompt and tool list are also projected

- Claude Code's ~10 KB system prompt is replaced by `PROJECTION_SYSTEM`, a lean,
  action-oriented loop contract (one tool per turn; read before edit; validate
  with tests; don't repeat a failing action; stop when validated).
- The ~60 incoming tool schemas are stripped to `DEFAULT_KEEP_TOOLS`
  (`Read`, `Write`, `Edit`, `Bash`, plus harness equivalents). Discovery
  (`ls`/`grep`/`find`) is funnelled through `Bash` so its output is cached and
  replayed. The model's response therefore uses tool names the upstream agent
  can actually execute.

### Two dialects, one engine

`generate_context(..., tools_dialect=…)` selects the tool vocabulary so the same
engine serves both paths:

| Path                         | dialect   | read tool        | command tool    |
| ---------------------------- | --------- | ---------------- | --------------- |
| In-process loop (`benchmark`)| `harness` | `read_file(path)`| `run_command`   |
| Proxy in front of Claude Code| `claude`  | `Read(file_path)`| `Bash(command)` |

### Prompt caching (cache-aware projection)

When the proxy fronts **real Claude** (native Anthropic API), projection also
places Anthropic `cache_control` breakpoints so its stable prefix is cached and
re-read at ~0.1× instead of re-processed every turn. The subtlety: projection
*rebuilds* the message array each turn, so a breakpoint on the volatile last
message caches almost nothing. `project_payload(..., cache_prefix=True)` instead
marks the **byte-stable** segments:

1. the **system** contract block (identity + loop rules never change),
2. the **tool list** (fixed at 4 tools),
3. the **last durable world observation** (the world is append-only, so
   everything above the newest entry is identical to last turn).

Volatile `<operational_memory>` / runtime reminders are relocated to the live
tail so they never bust the cached prefix. This reproduces Claude Code's own
incremental-caching shape and, in our suite, cut effective billed input **1.8×**
(see [`docs/RESULTS.md`](docs/RESULTS.md)). The Ollama path ignores
`cache_control`, so caching is auto-disabled there — the lean string system
prompt is used unchanged.

---

## How the caches use FUSE

Projection decides *how observations are compressed back into context*. **FUSE
is the observation layer** — the ground truth of what actually happened on the
filesystem. The two are complementary.

`FileSystemTracker` (in `benchmark.py`) mounts the task sandbox through a
**passthrough FUSE filesystem** (`fusepy` + macFUSE). Every tool then executes
against the mount instead of the raw directory:

```
agent tool ──▶  FUSE mount (passthrough) ──▶  real sandbox dir
                      │
                      └── journals every read()/write()/open()/create()/…
```

`_FusePassthroughOps` records each operation as `("r"|"w", path, ts)`. Around a
tool call the tracker brackets the journal:

- `begin_tool()` → marks the current journal index (and snapshots mtimes+hash)
- `end_tool()`   → `collect_since(idx)` returns the exact **read set** and
  **write set** for that single tool call

This gives per-tool, ground-truth I/O attribution — *which files this command
actually touched* — without parsing the model's prose.

### Cache ↔ FUSE in each path

- **In-process loop:** after each tool runs, `_sync_world()` walks the sandbox
  for anything whose mtime changed and refreshes the `WorldCache` with the real
  on-disk contents. So if a `pytest` run rewrites a file as a side effect, the
  next projected context reflects what's *actually* on disk, not what the model
  thinks it wrote. FUSE additionally supplies the precise read/write sets stored
  alongside each turn for analysis.
- **Claude Code via proxy:** Claude Code executes its own tools inside the FUSE
  mount, so the run's real read/write set and file integrity are still captured.
  The projection world, however, is rebuilt from the **conversation** flowing
  through the proxy (that is all the proxy can see) — `build_world_from_messages()`
  pairs every `tool_use` with its `tool_result` and folds them into a fresh
  `WorldCache` on each request.

### FUSE modes

`FileSystemTracker(root, mode=…, require_fuse=…)`:

| mode       | behavior                                                        |
| ---------- | -------------------------------------------------------------- |
| `auto`     | try FUSE, fall back to `snapshot` if unavailable (default)      |
| `fuse`     | require a working FUSE mount (raises if it can't mount)         |
| `snapshot` | no FUSE; diff by mtime + SHA-256 tree hash only                |

The mount is verified at startup with read and read-write probe files, and
rejected early if it is read-only or non-propagating. `--require-fuse` forces
real FUSE and fails loudly rather than silently degrading to snapshot.

> **Setup:** install [macFUSE](https://macfuse.io) (system-wide), then
> `pip install fusepy`. Without both, the tracker degrades to `snapshot` mode.

---

## Architecture at a glance

```
                          ┌──────────────────────────────────────┐
                          │  synaxi_projection/projection.py      │
                          │  • WorldCache (token-weighted LRU)    │
                          │  • ProjectionControlState (memory)    │
                          │  • generate_context() / project_payload()
                          └──────────────────────────────────────┘
                                 ▲                        ▲
              harness dialect    │                        │   claude dialect
        ┌────────────────────────┘                        └────────────────────────┐
        │                                                                           │
┌───────────────────────────┐                            ┌──────────────────────────────┐
│ benchmark.py (in-process)  │                            │ _proxy_server.py (MITM)        │
│  run_task() agent loop     │                            │  project_payload() per request │
│  executes tools itself     │                            │                                │
│  FileSystemTracker (FUSE)  │                            │  Claude Code ──▶ proxy ──▶ Ollama
│   observes the sandbox     │                            │  (native Anthropic API, v0.14+)│
└───────────────────────────┘                            └──────────────────────────────┘
```

Ollama speaks the Anthropic Messages API natively (v0.14.0+), so the proxy does
**no** format translation — it only projects, rewrites the model name, forces
non-streaming for logging, injects auth, and forwards.

---

## Module map

| File                    | Responsibility                                              |
| ----------------------- | ----------------------------------------------------------- |
| `projection.py`         | **Canonical projection engine** (world, memory, context).   |
| `benchmark.py`          | In-process agent loop, `FileSystemTracker` (FUSE), scoring.  |
| `_proxy_server.py`      | MITM proxy: projects each request, forwards, logs JSONL.     |
| `proxy.py`              | Start/stop the proxy; `apply_projection()` entrypoint.       |
| `wrapper.py` / `cli.py` | `synaxi-projection wrap claude …` Headroom-style wrapper.    |
| `sandbox.py`            | `TaskSandbox` temp working dirs + pytest/script runners.     |

**Benchmarking & analysis (`scripts/`)**

| File                          | Responsibility                                          |
| ----------------------------- | ------------------------------------------------------- |
| `run_suite.py`                | Full 31-task suite runner (projection / baseline / local). |
| `analyze_results.py`          | Honest token-cost + pass-rate analysis of any run(s).   |
| `suite_status.py`             | Live progress monitor for an in-flight suite.           |

---

## Benchmarking

> Interactive use is covered in **[Quick start](#quick-start)**. This section is
> the evaluation harness that produces the numbers above — it drives the same
> projection engine through a scored task suite.

FUSE observation is optional and needs macFUSE plus `fusepy` (see
[How the caches use FUSE](#how-the-caches-use-fuse)); without them the tracker
degrades to `snapshot` mode:

```bash
pip install fusepy
```

**In-process loop (local Ollama, FUSE-observed):**

```bash
synaxi-projection-benchmark \
  --provider ollama --model gemma4:latest \
  --projection --fs-tracker fuse --require-fuse
```

**Through Claude Code + the projection proxy:**

```bash
# start the proxy pointed at Ollama
python -m synaxi_projection.proxy --upstream http://127.0.0.1:11434 --model gemma4:latest &
# run benchmark tasks through `claude -p` via the proxy, with FUSE tracking
synaxi-projection-benchmark --claude-code --model gemma4:latest --fs-tracker fuse
```

## Full benchmark suite

`scripts/run_suite.py` runs the whole 31-task suite through the `claude -p` →
proxy → model path and writes one JSONL record per task to `data/runs/`.

```bash
# Projection through REAL Claude (uses your Claude subscription).
# Do NOT set ANTHROPIC_API_KEY / ANTHROPIC_AUTH_TOKEN — `claude -p` auths itself;
# native auth is auto-enabled when --upstream targets api.anthropic.com.
python scripts/run_suite.py --mode claude-code \
  --upstream https://api.anthropic.com --model haiku --fs-tracker snapshot

# Baseline A/B: same path, projection DISABLED (full growing transcript).
python scripts/run_suite.py --mode claude-code --no-projection \
  --upstream https://api.anthropic.com --model haiku --fs-tracker snapshot

# Local model through the proxy → Ollama.
python scripts/run_suite.py --mode claude-code \
  --upstream http://127.0.0.1:11434 --model gemma4:latest --fs-tracker snapshot
```

**Analyze / compare runs** — computes the honest token cost (fresh input +
cache write + cache read) that the naive counters hide:

```bash
# summarize every canonical run + regenerate the machine-readable rollup
python scripts/analyze_results.py data/results/*.jsonl --json data/results/summary.json

# per-task head-to-head between two runs
python scripts/analyze_results.py \
  data/results/haiku_projection.jsonl data/results/haiku_baseline.jsonl --compare
```

See [`docs/RESULTS.md`](docs/RESULTS.md) for the published numbers.

---

## Conversation logs

- The proxy appends every projected request + upstream response to
  `~/.synaxi-projection/conversations/session_<ts>.jsonl`, including
  `projection_meta` (original vs projected system length, tool count, message
  count) so you can see exactly how much was compressed.
- The benchmark writes a full per-run artifact to
  `data/conversation_history/` (and `…/claude_code/` for the proxy path) with
  every turn, token counts, tool calls, and the FUSE tracker mode used.

---

## Scope

- ✅ Projection / context-control behavior
- ✅ Harness execution + conversation history logging
- ✅ FUSE / snapshot filesystem observation
- ❌ Token optimization / compression techniques from the main Synaxi product
