# synaxi-projection

## Quick Start: Use with Claude Code

```bash
pip install -e .

# Wrap the Claude Code TUI (uses your existing Claude subscription/auth).
# Launches the synaxi-chat orchestrator, which delegates coding to the
# projected synaxi-worker subagent.
synaxi-projection wrap claude
```

That's it — this starts the projection proxy, routes Claude Code through it,
and launches `claude` as usual. Use it like normal Claude Code; only the
worker subagent's requests get projected. When you're done, exit the session
and optionally clean up:

```bash
synaxi-projection status
synaxi-projection doctor
synaxi-projection unwrap claude
```

See [Install](#install) and [Run](#run) below for more configuration options.

---

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
   loop; a local proxy projects the coding **worker** subagent's requests before
   they reach the upstream model (local Ollama *or* real Claude). Interactive
   chat and UI requests pass through untouched — see
   [Two agents](#two-agents-a-chat-orchestrator-in-front-of-a-projected-worker).

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
user:       <goal>
assistant:  tool_use   Bash(ls -F)          (synthetic id syn_…)
user:       tool_result "test_event_emitter.py"
assistant:  tool_use   Read(test_event_emitter.py)
user:       tool_result "import pytest …"
assistant:  tool_use   Bash(python3 -m pytest)
user:       tool_result "exit=1 … ModuleNotFoundError"
assistant:  tool_use   <the real most-recent action>   (verbatim, Claude's id)
user:       tool_result <the real most-recent result>
              + <system-reminder> (the agent's distilled operational memory)
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

Repeated tool failures are distilled into a short block and delivered as a
trusted `<system-reminder>` in the live tail, e.g.:

- `python: command not found` → "Use `python3` (not `python`) in this sandbox."
- reading a directory as a file → "use `run_command` (`ls`/`find`) for discovery."
- the same path failing twice → "list files first, then read exact paths."

This is how the agent *learns within a run* without re-deriving the same lesson
every turn. It rides in a `<system-reminder>` — the same convention Claude Code
uses for its own in-band dynamic context — and is explicitly framed as the
agent's *own* distilled memory ("not user input"). That matters when the proxy
fronts a full model: an imperative appended after a `tool_result` reads exactly
like a prompt-injection attempt (a real worker flagged and refused it), whereas
a `<system-reminder>` is trusted context the model applies to itself.

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

Volatile `<system-reminder>` blocks (operational memory + runtime reminders)
are relocated to the live tail so they never bust the cached prefix. This reproduces Claude Code's own
incremental-caching shape and, in our suite, cut effective billed input **1.8×**
(see [`docs/RESULTS.md`](docs/RESULTS.md)). The Ollama path ignores
`cache_control`, so caching is auto-disabled there — the lean string system
prompt is used unchanged.

---

## Two agents: a chat orchestrator in front of a projected worker

Projection only helps an agent that *accumulates* a long transcript.
Interactive chat turns, `/init`, autocomplete, and MCP sidecar calls don't need
it — projecting them would strip context the UI expects. So `wrap claude`
installs **two** Claude Code subagents and projects only one of them:

| Agent | Tools | Proxy treatment |
| ----- | ----- | --------------- |
| **`synaxi-chat`** | `Agent(synaxi-worker)`, `AskUserQuestion` | **passthrough** — a code-free orchestrator that *grills* the user one question at a time (each with a recommended answer, offered as structured `AskUserQuestion` choices when the decision is discrete) into a self-contained, BDD-shaped brief, then delegates it to the worker |
| **`synaxi-worker`** | `Read` `Write` `Edit` `Bash` `Grep` `Glob` | **projected** — the autonomous coder whose ever-growing context is what projection shrinks to constant space |

> `AskUserQuestion` depends on the conversation UI, so Claude Code blocks it for
> *spawned* subagents. `synaxi-chat` runs as the **main** session agent
> (`--agent synaxi-chat`), so it owns the UI and may use it; the headless worker
> never can.


### How the proxy tells them apart: a sentinel, not a fingerprint

A custom subagent's markdown body **is** its API `system` prompt, verbatim (a
documented Claude Code behaviour). So `synaxi-worker`'s prompt carries a fixed
sentinel — `WORKER_SENTINEL = "SYNAXI-PROJECTION-WORKER"` — and the proxy
projects a request iff its `system` text contains it:

```python
is_worker  = is_worker_payload(payload)          # substring match on system text
do_project = (not DISABLE_PROJECTION) and (PROJECT_ALL or is_worker)
```

This is a deterministic *stamp we control*, not a heuristic that guesses from
prompt shape — so it can't drift as Claude Code's own prompts change between
versions. Every logged request records `is_worker` / `projected` in its
`projection_meta`, so the gate is auditable after the fact.

- `SYNAXI_PROJECT_ALL=1` restores the old "project every request" behaviour
  (used to A/B a small local model with no custom agent).
- `SYNAXI_DISABLE_PROJECTION=1` forwards everything untouched (pure MITM logger).

### Why split the roles

A projected context is a *lossy, reconstructed* view — right for a headless
coder that only needs its durable observations, wrong for a conversation where
the user's exact phrasing matters. Splitting the roles lets each half get the
treatment it needs: the chat agent keeps full fidelity for talking to you; the
worker runs on constant-space projected context so a small or local model can
carry a long task without drowning or looping. `wrap` installs both agents into
the Claude Code agents dir for the session and removes them on exit (see
[What wrapping does](#run)).

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
| `projection.py`         | **Canonical projection engine** (world, memory, context, worker sentinel gate). |
| `benchmark.py`          | In-process agent loop, `FileSystemTracker` (FUSE), scoring.  |
| `_proxy_server.py`      | MITM proxy: gates + projects each request, forwards, logs JSONL. |
| `proxy.py`              | Start/stop the proxy; `apply_projection()` entrypoint.       |
| `wrapper.py` / `cli.py` | `synaxi-projection wrap claude …` wrapper; installs/removes agents. |
| `agents/*.md`           | Bundled subagents: `synaxi-chat` (orchestrator) + `synaxi-worker` (projected). |
| `sandbox.py`            | `TaskSandbox` temp working dirs + pytest/script runners.     |

**Benchmarking & analysis (`scripts/`)**

| File                          | Responsibility                                          |
| ----------------------------- | ------------------------------------------------------- |
| `run_suite.py`                | Full 31-task suite runner (projection / baseline / local). |
| `analyze_results.py`          | Honest token-cost + pass-rate analysis of any run(s).   |
| `suite_status.py`             | Live progress monitor for an in-flight suite.           |

---

## Install

```bash
pip install -e .
# optional, for real FUSE observation (plus system macFUSE):
pip install fusepy
```

## Run

**Benchmark, in-process loop (local Ollama, FUSE-observed):**

```bash
synaxi-projection-benchmark \
  --provider ollama --model gemma4:latest \
  --projection --fs-tracker fuse --require-fuse
```

**Benchmark through Claude Code + the projection proxy:**

```bash
# start the proxy pointed at Ollama
python -m synaxi_projection.proxy --upstream http://127.0.0.1:11434 --model gemma4:latest &
# run benchmark tasks through `claude -p` via the proxy, with FUSE tracking
synaxi-projection-benchmark --claude-code --model gemma4:latest --fs-tracker fuse
```

**Wrap the Claude Code TUI:**

```bash
# Against real Claude (uses your Claude subscription; `claude` auths itself).
# Launches the synaxi-chat orchestrator, which delegates coding to the
# projected synaxi-worker subagent.
synaxi-projection wrap claude

# Against a local Ollama model instead.
synaxi-projection wrap claude --upstream http://127.0.0.1:11434 --model gemma4:latest

synaxi-projection status
synaxi-projection doctor
synaxi-projection unwrap claude
```

What wrapping does:

1. Starts the projection proxy on `http://127.0.0.1:<port>`.
2. Writes `ANTHROPIC_BASE_URL` into `.claude/settings.local.json` so every
   Claude Code session (including daemon-spawned workers) routes through it.
3. Installs the bundled `synaxi-chat` and `synaxi-worker` subagents into the
   Claude Code agents dir (honouring `CLAUDE_CONFIG_DIR`), saving any
   same-named agents first.
4. Launches `claude --agent synaxi-chat` with the env var set. Only the worker's
   requests get projected (via the sentinel gate above).
5. On exit — even after a crash — restores settings, removes the installed
   agents (or restores the saved originals), and stops the proxy.

Flags: `--agent <name>` launches a different session agent (default
`synaxi-chat`); `--no-agent` launches plain Claude Code with no agent; both are
only honoured when the agent definition exists on disk. Any flag the wrapper
doesn't recognise (e.g. `--dangerously-skip-permissions`) is forwarded verbatim
to the `claude` binary.

> Ensure `~/.local/bin` is earlier in `PATH` than the original Claude install.

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
