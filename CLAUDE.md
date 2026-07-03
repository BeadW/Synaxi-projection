# CLAUDE.md

Guidance for Claude Code instances working in this repository.

## What this repo is

**synaxi-projection** is the runtime + benchmark harness for *context
projection*: shrinking a coding agent's ever-growing conversation transcript
down to a small, constant-space context that a (often local/small) model can
run without losing working memory or looping. It's a separate repo from
`synaxi-predict`; scope here is projection only (no token-compression tricks
from the main Synaxi product — see "Out of scope" below).

Two execution paths exercise the same projection engine
(`synaxi_projection/projection.py`):

1. **In-process agent loop** (`synaxi_projection/benchmark.py`) — the harness
   owns the tool loop and executes tools itself against a sandbox observed
   through FUSE.
2. **Claude Code via a MITM proxy** (`synaxi_projection/_proxy_server.py`) —
   Claude Code owns the loop; a local HTTP proxy projects every Anthropic
   Messages API request before forwarding it to Ollama (or Anthropic).

Read `README.md` and `docs/RESULTS.md` for full architecture diagrams and
benchmark numbers before making non-trivial changes — they're accurate and
detailed, this file intentionally does not duplicate them.

## Repo layout

```
synaxi_projection/       Package: the actual product code
  projection.py            Canonical projection engine — WorldCache (token-
                            weighted LRU of durable tool observations),
                            ProjectionControlState (operational memory),
                            generate_context(), project_payload(),
                            is_worker_payload() (gates projection to the
                            worker subagent only).
  benchmark.py              In-process agent loop + FileSystemTracker (FUSE)
                            + scoring; CLI entry `synaxi-projection-benchmark`.
  _proxy_server.py          MITM HTTP proxy: projects each request, streams
                            SSE back to Claude Code, forwards, logs JSONL.
                            Config via SYNAXI_UPSTREAM / SYNAXI_PORT /
                            SYNAXI_MODEL / SYNAXI_DISABLE_PROJECTION /
                            SYNAXI_PROJECT_ALL / SYNAXI_LOG_DIR env vars.
  proxy.py                  Start/stop the proxy process; `apply_projection()`
                            entrypoint; CLI entry `synaxi-proxy`.
  wrapper.py / cli.py        `synaxi-projection wrap claude …` — Headroom-style
                            wrapper that injects ANTHROPIC_BASE_URL into
                            `.claude/settings.local.json`, launches `claude`,
                            installs/removes the bundled subagents, restores
                            state on exit. CLI entry `synaxi-projection`
                            (subcommands: wrap, unwrap, status, doctor).
  sandbox.py                 TaskSandbox: temp working dirs + pytest/script
                            runners for single/multi-turn eval fixtures.
  agents/*.md                Bundled Claude Code subagent definitions:
                              - synaxi-chat.md: tool-free orchestrator that
                                gathers requirements and delegates to...
                              - synaxi-worker.md: the autonomous coding
                                worker whose growing context is what actually
                                gets projected (its system prompt carries the
                                WORKER_SENTINEL that is_worker_payload() looks
                                for — this gates projection to worker turns
                                only, leaving interactive chat/UI requests
                                untouched).
harness/                 Separate in-process test harness (runner, sandbox,
                          evaluator, recorder, agent strategies) used for
                          feature-driven benchmark tasks. `harness/tests/`
                          uses pytest-bdd against `features/*.feature` files;
                          `pytest-bdd` is NOT a listed dependency and is
                          usually not installed, so `pytest harness/tests`
                          fails with `ModuleNotFoundError: pytest_bdd` unless
                          you `pip install pytest-bdd` first. `pyproject.toml`
                          scopes `testpaths = ["tests"]`, so the default
                          `python3 -m pytest -q` never touches `harness/`.
features/                Benchmark task fixtures, grouped by category:
                          research/ analysis/ planning/ code/ review/ fixtures/
scripts/                  Suite orchestration & analysis, run standalone:
  run_suite.py              Full 31-task suite runner (projection / baseline
                            / local paths).
  analyze_results.py        Honest token-cost + pass-rate analysis of run(s).
  suite_status.py            Live progress monitor for an in-flight suite.
tests/                   pytest unit tests for the package (see below).
data/                    Benchmark inputs/outputs: results/, runs/,
                          transcripts/, conversation_history/ (gitignored
                          content mixed with tracked JSONL — check `git
                          status` before assuming a data file is safe to
                          overwrite).
docs/RESULTS.md          Benchmark methodology + headline numbers; regenerate
                          with `python scripts/analyze_results.py
                          data/results/*.jsonl --json data/results/summary.json`.
```

## Setup

```bash
pip install -e .            # editable install; deps are stdlib-only by default
pip install -e ".[dev]"     # + pytest
pip install -e ".[fuse]"    # + fusepy, for real FUSE-observed benchmarks (needs macFUSE)
```

There is a project `.venv/` present in some checkouts — check `which python3`
if commands behave unexpectedly. `python3` (not `python`) is the correct
interpreter to invoke everywhere in this repo.

## Common commands

Run all tests:
```bash
python3 -m pytest -q
```

Run a single test file / test:
```bash
python3 -m pytest -q tests/test_proxy_streaming.py
python3 -m pytest -q tests/test_wrap_settings.py::test_unwrap_removes_auth_token
```

Lint (ruff is available on this machine but is **not** wired into
`pyproject.toml`, CI, or a Makefile — there is no committed ruff config, so
treat any ruff invocation as best-effort/manual, matching how it was used in
past commits, e.g. `5058f81 chore: fix ruff lint`):
```bash
ruff check .
```

Run the in-process benchmark (local Ollama, FUSE-observed):
```bash
synaxi-projection-benchmark \
  --provider ollama --model gemma4:latest \
  --projection --fs-tracker fuse --require-fuse
```

Run the proxy standalone, then drive it with the benchmark harness or with
Claude Code:
```bash
python3 -m synaxi_projection.proxy --upstream http://127.0.0.1:11434 --model gemma4:latest &
synaxi-projection-benchmark --claude-code --model gemma4:latest --fs-tracker fuse
```

Wrap the interactive Claude Code TUI so it routes through the projection
proxy:
```bash
synaxi-projection wrap claude --upstream http://127.0.0.1:11434 --model gemma4:latest
synaxi-projection status
synaxi-projection doctor
synaxi-projection unwrap claude
```
`wrap` writes `ANTHROPIC_BASE_URL` into `.claude/settings.local.json` (this
file is gitignored — it's local proxy state, not project config) and installs
the `synaxi-chat` / `synaxi-worker` subagents for the session, removing both
on exit.

Full 31-task benchmark suite + analysis:
```bash
python scripts/run_suite.py
python scripts/analyze_results.py data/results/*.jsonl --json data/results/summary.json
python scripts/suite_status.py   # monitor an in-flight run
```

There is no build step (pure Python, no bundler) and no CI workflow files in
this repo (`.github/` does not exist) — validate changes locally with pytest
and, where relevant, an actual benchmark/proxy run.

## Architecture notes worth knowing before editing

- **Projection is gated to the worker subagent only.**
  `is_worker_payload()` in `projection.py` checks the request's `system` text
  for `WORKER_SENTINEL`, which lives in `agents/synaxi-worker.md`'s prompt
  body. Only requests from that subagent get projected; interactive chat,
  `/init`, the `synaxi-chat` orchestrator, and MCP sidecar requests are
  forwarded untouched. If you change the worker agent's prompt, keep the
  sentinel intact or update the detection logic together with it.
- **`project_payload()` never emits `"tools": null`.** Anthropic's API
  rejects that. When there are no tools for a request, the `tools` and
  `tool_choice` keys are dropped entirely — don't reintroduce a `None`
  assignment there (see `tests/test_tools_null.py`).
- **All client-defined tools are kept by default** (`keep_tools=None`);
  `DEFAULT_KEEP_TOOLS` is an opt-in trim used only for controlled benchmark
  comparisons, not normal use. Don't default-narrow the tool vocabulary in
  new code paths.
- **`WorldCache`** is a token-weighted LRU of durable tool-call/result pairs;
  `ProjectionControlState` layers small "operational memory" notes on top.
  Together with the most recent live tool pair, `generate_context()` rebuilds
  a valid Anthropic messages array every request — never a single frozen
  pair, which is what caused small local models to loop.
- **Operational memory / runtime notices are delivered as `<system-reminder>`
  blocks, not `<operational_memory>`.** A native (full Claude) projection
  worker once flagged a bare `<operational_memory>` block + "Apply this
  memory..." imperative appended after a `tool_result` as a prompt-injection
  attempt and refused it. `<system-reminder>` is Claude Code's own convention
  for trusted in-band dynamic context, so the model treats it as its own
  distilled memory rather than untrusted input. Both blocks still ride in the
  volatile tail (after the cache breakpoint) so the cached prefix stays
  byte-stable. See `tests/test_operational_memory.py`.
- **Prompt caching is cache-aware, not automatic.** `cache_prefix` is on by
  default for the native Claude path (`preserve_claude_identity=True`) and
  off for Ollama (which ignores `cache_control`). Correct cache-breakpoint
  placement is the difference between the "uncached" and "cache-aware" rows
  in `docs/RESULTS.md`.
- **The proxy does no format translation.** Ollama speaks the Anthropic
  Messages API natively (v0.14.0+), so `_proxy_server.py` only projects,
  rewrites the model name, and forwards. SSE streaming re-emission back to
  the interactive Claude Code TUI (including thinking-block signatures) is a
  currently-active area — see `tests/test_proxy_streaming.py` and recent log
  history below.
- **`harness/`** is a distinct, separate in-process test harness (runner,
  sandbox, evaluator, agent strategies) from `synaxi_projection/benchmark.py`
  — don't conflate the two when navigating "how does an agent loop work
  here"; check which one a task/file actually touches.

## Current branch context

You are likely on `fix/proxy-streaming-sse` or a similar in-flight branch.
Recent history on this line of work (most recent first):
- Deliver operational memory as a trusted `<system-reminder>` (not a bare
  `<operational_memory>` block) — see the Architecture notes above.
- Preserve thinking-block signatures in SSE re-emission.
- Wrap installs/removes bundled agent definitions per session.
- Gate projection on worker subagent; add chat orchestrator.
- Fix wrapper auth-token keying off upstream (clear stale token on native).
- Keep all client tools by default (trim is opt-in).
- Never emit `"tools": null` (fixed `wrap claude` 400 errors).
- Stream SSE to interactive Claude Code (fixed empty/malformed HTTP 200).

When working on proxy/streaming issues, `tests/test_proxy_streaming.py` and
`_proxy_server.py`'s `_sse_event()` / `_message_to_sse()` helpers are the
relevant surface.

## Out of scope

Per `README.md`: this repo does **not** include token optimization /
compression techniques from the main Synaxi product. Don't pull those in or
assume they exist here — projection (constant-space context reconstruction)
is the only technique in scope.

## Conventions

- Follow the existing agent-loop conventions embedded in
  `synaxi_projection/agents/synaxi-worker.md` when acting as an autonomous
  worker in this repo: one tool call per turn, read before edit, verify with
  a real test/command run before claiming success, use `python3` not
  `python`.
- `data/` mixes tracked and gitignored content (results/runs vs. transient
  conversation logs) — run `git status` before assuming a file under `data/`
  is safe to overwrite or regenerate.
- `.claude/settings.local.json` is local, gitignored proxy state written by
  `synaxi-projection wrap` — never hand-edit it expecting the change to
  persist or be reviewed; it's regenerated per session.
