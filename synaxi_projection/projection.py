"""
synaxi_projection.projection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Canonical context-projection engine for Synaxi — the single source of truth for
how the projection agent's working context is rebuilt on every turn.

It is shared by the two execution paths:

  * ``benchmark.py``      — the in-process agent loop. The harness owns the loop
                            and executes tools itself, calling
                            :class:`WorldCache`, :class:`ProjectionControlState`
                            and :func:`generate_context` directly.

  * ``_proxy_server.py``  — the MITM proxy in front of Claude Code. Here Claude
                            Code owns the loop; the proxy reconstructs the world
                            from the message history that flows through it on
                            each request, via :func:`project_payload`.

Projection in one sentence
--------------------------
Instead of forwarding Claude Code's ever-growing transcript (a ~10 KB system
prompt + ~60 tool schemas + every prior turn) to a small local model, we
rebuild a *constant-space* context from the durable facts the agent has
observed — the files it has read/written and the commands it has run — and
re-emit them as native, correctly-paired ``tool_use`` / ``tool_result``
messages, plus a small ``<operational_memory>`` block of lessons learned.

Why native tool pairs (not a prose summary)
-------------------------------------------
Tool-calling models are trained on the ``assistant(tool_use) -> user(tool_result)``
shape. Re-emitting observations as real pairs (rather than a ``<current_files>``
text blob) keeps the model on-distribution and lets it reason about results the
same way it would live. Critically, **every** synthesized ``tool_use`` is
immediately followed by its ``tool_result``, so the projected payload stays a
valid Anthropic Messages request for Ollama's native endpoint — and the model
always sees the *full* progression of its work (the ``ls`` output, the test
file it read, the failing ``pytest`` run) instead of a single frozen pair.

This is the bug this module exists to prevent: if projection collapses history
to one pair and drops command output, the agent never sees the result of its
last action and loops forever, re-running ``ls`` / re-reading the same file.

Relationship to FUSE
--------------------
The proxy reconstructs the world from the *conversation* (the only thing it can
see). The benchmark's :class:`~synaxi_projection.benchmark.FileSystemTracker`
mounts the sandbox through a passthrough **FUSE** filesystem so the harness can
capture the ground-truth read/write set of every tool execution and refresh the
:class:`WorldCache` with whatever actually changed on disk. The two mechanisms
are complementary: FUSE is the *observation* layer (what really happened on the
filesystem); this module is the *projection* layer (how those observations are
compressed back into the model's context). See the README for the full diagram.
"""
from __future__ import annotations

import hashlib
from typing import Optional

__all__ = [
    "WorldCache",
    "ProjectionControlState",
    "generate_context",
    "project_payload",
    "build_world_from_messages",
    "sanitize_task",
    "PROJECTION_SYSTEM",
    "CLAUDE_CODE_IDENTITY",
    "DEFAULT_KEEP_TOOLS",
]


# ---------------------------------------------------------------------------
# System prompt for the projected (small-model) context.
#
# Tuned for the proxy / Claude-Code path: Claude Code drives the loop, so the
# model only needs to pick the next single action. We deliberately keep this
# lean and action-oriented (no strict annotation protocol) because there is no
# harness retry loop to absorb malformed annotation-only turns.
# ---------------------------------------------------------------------------
PROJECTION_SYSTEM = (
    "You are an autonomous coding agent operating in a sandbox through tools.\n"
    "\n"
    "Operating contract:\n"
    "- Work in a loop: observe -> act with ONE tool -> observe the result -> adjust.\n"
    "- Emit exactly one tool call per turn. Never reply with a plan and no tool call.\n"
    "- Read a file before you edit it. Use Edit for small changes, Write for new files.\n"
    "- After changing code, run the tests/validation command to get real evidence.\n"
    "- Do not claim success until a tool result proves it (e.g. exit 0 / tests pass).\n"
    "- If an action fails, do not repeat it unchanged — use the error to change approach.\n"
    "- Files and command output already shown above as tool results are loaded; do NOT\n"
    "  re-read or re-run them unless a newer result shows they are stale.\n"
    "- Use `python3` (not `python`) for commands in this sandbox.\n"
    "- Only once the task is validated, stop and give a short final summary."
)


# Tool names worth keeping in the projected request. Everything else Claude Code
# ships (~60 schemas) is stripped to save context. Discovery (ls/grep/find) is
# funnelled through Bash so its output lands in the WorldCache and is replayed.
DEFAULT_KEEP_TOOLS = {
    # Claude Code native tools
    "Read", "Write", "Edit", "Bash",
    # harness-style tools (when upstream uses the in-process loop vocabulary)
    "read_file", "write_file", "run_command",
    # anthropic computer-use / text-editor tool aliases
    "str_replace_based_edit_tool",
}


# tool-name dialects: (tool_name, path/arg key) for the read tool, and for cmd.
_DIALECTS = {
    "harness": {"read": ("read_file", "path"), "cmd": ("run_command", "command")},
    "claude": {"read": ("Read", "file_path"), "cmd": ("Bash", "command")},
}

# Map vendor tool names onto the harness vocabulary so ProjectionControlState's
# heuristics (which key off "run_command" / "read_file") work for either source.
_NAME_MAP = {
    "Read": "read_file",
    "Write": "write_file",
    "Edit": "write_file",
    "str_replace_based_edit_tool": "write_file",
    "Bash": "run_command",
}


# ---------------------------------------------------------------------------
# Anthropic prompt-caching helpers.
#
# ``cache_control`` marks the end of a stable prefix segment: everything
# before the marker is cached and re-read (~0.1x) on the next turn instead
# of re-processed. We only ever mark byte-stable segments (system, tools,
# and the append-only world tail), and we strip inherited markers so the
# 4-breakpoint budget stays exact and deterministic.
# ---------------------------------------------------------------------------
_EPHEMERAL = {"type": "ephemeral"}


def _with_cc(block: dict) -> dict:
    """Return a shallow copy of ``block`` carrying a cache breakpoint."""
    b = dict(block)
    b["cache_control"] = dict(_EPHEMERAL)
    return b


def _strip_cc(block):
    """Return ``block`` without any inherited ``cache_control`` marker."""
    if isinstance(block, dict) and "cache_control" in block:
        b = dict(block)
        b.pop("cache_control", None)
        return b
    return block


# ===========================================================================
# WorldCache — token-weighted observation cache (verbatim shared definition)
# ===========================================================================

class WorldCache:
    """Observation cache for the projection agent.

    Stores files read and command output. Eviction is token-weighted:
    large entries that haven't been used recently cost the most to keep
    and are evicted first. Small entries like ls output stay around longer.

    Eviction strategy: score = tokens * turns_since_used.
    When total tokens exceed budget, evict highest-score entries first.
    """

    def __init__(self, token_budget: int = 8000):
        self._budget = token_budget
        self._store: dict[str, str] = {}
        self._last_used: dict[str, int] = {}
        self._turn: int = 0

    def tick(self) -> None:
        """Advance turn, evict entries if over token budget."""
        self._turn += 1
        total = sum(len(v) // 4 for v in self._store.values())
        if total <= self._budget:
            return
        # Score = token_cost * turns_since_used — highest score evicts first
        scored = sorted(
            self._store.keys(),
            key=lambda k: (len(self._store[k]) // 4) * (self._turn - self._last_used[k]),
            reverse=True,
        )
        for k in scored:
            token_cost = len(self._store[k]) // 4
            del self._store[k]
            del self._last_used[k]
            total -= token_cost
            if total <= self._budget:
                break

    def put(self, key: str, content: str) -> None:
        self._store[key] = content
        self._last_used[key] = self._turn

    def get(self, key: str, default: Optional[str] = None) -> Optional[str]:
        return self._store.get(key, default)

    def items(self):
        return self._store.items()


# ===========================================================================
# ProjectionControlState — small persistent operational memory
# ===========================================================================

class ProjectionControlState:
    """Small persistent operational memory for projection-mode recovery.

    Learns from repeated tool failures (e.g., `python` unavailable, reading dirs as files)
    and provides concise reminders in the next turn's compact context.
    """

    def __init__(self) -> None:
        self._facts: dict[str, str] = {}
        self._error_counts: dict[str, int] = {}

    def _remember(self, key: str, text: str) -> None:
        self._facts[key] = text

    def _bump_error(self, signature: str) -> int:
        nxt = self._error_counts.get(signature, 0) + 1
        self._error_counts[signature] = nxt
        return nxt

    def observe(self, tool_name: str, tool_input: dict, result_text: str) -> None:
        lower = (result_text or "").lower()

        if tool_name == "run_command":
            cmd = str(tool_input.get("command", ""))
            if "python: command not found" in lower:
                self._remember("python_bin", "Use `python3` (not `python`) in this sandbox.")

            if "exit=0" in lower and "python3" in cmd:
                self._remember("python_bin_confirmed", "`python3` works here; keep using it for test/validation commands.")

        if tool_name == "read_file":
            if "is a directory" in lower:
                self._remember(
                    "read_file_directory",
                    "`read_file` expects a file path; use `run_command` (`ls`/`find`) for directory discovery.",
                )

            if "not found" in lower:
                seen = self._bump_error("read_file:not_found")
                if seen >= 2:
                    self._remember(
                        "path_resolution",
                        "When paths fail, list files first (`ls`, `find . -maxdepth 3 -type f`) then read exact file paths.",
                    )

        if "tool error" in lower:
            seen = self._bump_error(f"tool_error:{tool_name}")
            if seen >= 2:
                self._remember(
                    f"repeat_{tool_name}",
                    f"Repeated {tool_name} errors detected; change strategy before retrying the same call.",
                )

    def render(self) -> str:
        if not self._facts:
            return "(none yet)"
        return "\n".join(f"- {item}" for item in self._facts.values())


# ===========================================================================
# generate_context — build the messages array from current world state
# ===========================================================================

def generate_context(
    goal: str,
    world: "WorldCache",
    last_tool_use: list,
    last_tool_result: list,
    control_state: Optional[str] = None,
    runtime_notice: Optional[str] = None,
    cwd: str = "",
    tools_dialect: str = "harness",
    cache_prefix: bool = False,
) -> list[dict]:
    """Construct the messages array for one agent invocation from current state.

    World entries are emitted as native tool call pairs:
      - file paths  -> synthesized read tool (``read_file`` / ``Read``) + tool_result
      - ``cmd:<command>`` keys -> synthesized command tool (``run_command`` / ``Bash``) + tool_result

    The model sees its own prior observations in the same format it produced
    them. ``tools_dialect`` selects the tool vocabulary:
      - ``"harness"`` -> ``read_file`` / ``run_command`` (in-process agent loop)
      - ``"claude"``  -> ``Read`` / ``Bash`` (proxy in front of Claude Code, so the
        model's *response* uses tool names Claude Code can actually execute)

    Token-weighted LRU eviction (via ``world.tick()``) keeps the world bounded.
    """
    dia = _DIALECTS.get(tools_dialect, _DIALECTS["harness"])
    read_name, read_key = dia["read"]
    cmd_name, cmd_key = dia["cmd"]

    cwd_note = f"\n\nWorking directory: {cwd}" if cwd else ""
    control_note = ""
    if control_state and control_state != "(none yet)":
        control_note = (
            "\n\n<operational_memory>\n"
            f"{control_state}\n"
            "</operational_memory>\n"
            "Apply this memory when choosing tools/commands unless a newer tool result disproves it."
        )
    notice = ""
    if runtime_notice:
        notice = (
            "\n\n<runtime_reminder>\n"
            f"{runtime_notice}\n"
            "</runtime_reminder>"
        )

    # msg[0] is the stable goal ONLY. Volatile operational memory / runtime
    # reminders are relocated to the live tail (below) so this prefix stays
    # byte-stable across turns and therefore cacheable.
    goal_block = {"type": "text", "text": goal + cwd_note}
    msgs: list[dict] = [{"role": "user", "content": [goal_block]}]
    last_world_result_block = None

    for key, content in world.items():
        tool_id = "syn_" + hashlib.md5(key.encode("utf-8", "replace")).hexdigest()[:10]
        if key.startswith("cmd:"):
            command = key[4:]
            msgs.append({"role": "assistant", "content": [
                {"type": "tool_use", "id": tool_id, "name": cmd_name, "input": {cmd_key: command}}
            ]})
        else:
            msgs.append({"role": "assistant", "content": [
                {"type": "tool_use", "id": tool_id, "name": read_name, "input": {read_key: key}}
            ]})
        world_result_block = {"type": "tool_result",
                              "tool_use_id": tool_id, "content": content}
        msgs.append({"role": "user", "content": [world_result_block]})
        last_world_result_block = world_result_block

    # Cache breakpoint on the stable prefix: mark the last world observation
    # (or the goal, on the very first turns) so system + tools + goal + world
    # are cached and only the freshly-appended tail is re-written each turn.
    if cache_prefix:
        if last_world_result_block is not None:
            last_world_result_block["cache_control"] = dict(_EPHEMERAL)
        else:
            goal_block["cache_control"] = dict(_EPHEMERAL)

    # Volatile tail: the live pair (verbatim, minus any inherited
    # cache_control so our breakpoint budget stays exact) plus the relocated
    # operational memory / runtime reminder as a trailing text block.
    tail_note = (control_note + notice).strip()
    if last_tool_use:
        msgs.append({"role": "assistant",
                     "content": [_strip_cc(b) for b in last_tool_use]})
    if last_tool_result:
        live_content = [_strip_cc(b) for b in last_tool_result]
        if tail_note:
            live_content.append({"type": "text", "text": tail_note})
        msgs.append({"role": "user", "content": live_content})
    elif tail_note:
        msgs.append({"role": "user",
                     "content": [{"type": "text", "text": tail_note}]})

    return msgs


# ===========================================================================
# Proxy-side helpers: rebuild the world from Claude Code's message history
# ===========================================================================

def _blocks(message: dict) -> list:
    content = message.get("content")
    return content if isinstance(content, list) else []


def _extract_text(message: dict) -> str:
    content = message.get("content", "")
    if isinstance(content, str):
        return content
    if isinstance(content, list):
        return " ".join(
            b.get("text", "") for b in content
            if isinstance(b, dict) and b.get("type") == "text"
        )
    return str(content)


def _result_text(tool_result_block: dict) -> str:
    content = tool_result_block.get("content", "")
    if isinstance(content, list):
        return " ".join(
            b.get("text", "") for b in content if isinstance(b, dict)
        )
    return str(content)


def _path_of(inp: dict) -> str:
    return inp.get("file_path") or inp.get("path") or ""


def _extract_pairs(messages: list[dict]) -> list[tuple[dict, dict]]:
    """Return ordered (tool_use, tool_result) pairs, matched by id.

    Only pairs whose ``tool_use.id`` has a corresponding ``tool_result`` are
    returned — never a dangling tool_use. Order follows the assistant tool_use
    order, so the final element is the most recent completed observation.
    """
    results: dict[str, dict] = {}
    for m in messages:
        if m.get("role") != "user":
            continue
        for b in _blocks(m):
            if isinstance(b, dict) and b.get("type") == "tool_result":
                rid = b.get("tool_use_id")
                if rid and rid not in results:
                    results[rid] = b

    pairs: list[tuple[dict, dict]] = []
    for m in messages:
        if m.get("role") != "assistant":
            continue
        for b in _blocks(m):
            if isinstance(b, dict) and b.get("type") == "tool_use":
                tid = b.get("id")
                if tid and tid in results:
                    pairs.append((b, results[tid]))
    return pairs


def _ingest(world: "WorldCache", name: str, inp: dict, result: str) -> None:
    """Fold a single tool observation into the world cache."""
    n = (name or "").lower()
    if n in ("read", "read_file"):
        path = _path_of(inp)
        if path:
            world.put(path, result)
    elif n in ("write", "write_file"):
        path = _path_of(inp)
        content = inp.get("content")
        if path:
            world.put(path, content if content is not None else result)
    elif n in ("edit", "str_replace_based_edit_tool", "str_replace"):
        path = _path_of(inp)
        if path:
            old = inp.get("old_string")
            new = inp.get("new_string")
            cur = world.get(path)
            if cur is not None and old:
                world.put(path, cur.replace(old, new if new is not None else "", 1))
            # otherwise leave the last-known content; the edit's tool_result is
            # still surfaced via the live pair if this was the most recent action.
    elif n in ("bash", "run_command"):
        cmd = inp.get("command", "")
        if cmd:
            world.put(f"cmd:{cmd}", result)
    # other tools (Glob/Grep/Web*) are intentionally not cached.


def build_world_from_messages(
    messages: list[dict],
) -> tuple["WorldCache", "ProjectionControlState", list[tuple[dict, dict]]]:
    """Reconstruct (world, control, pairs) from a Claude Code message history.

    ``control`` learns from *every* observation. ``world`` holds every
    observation except the most recent one — that final pair is returned
    separately so the caller can present it verbatim as the live stimulus
    (preserving Claude Code's real tool ids/names).
    """
    pairs = _extract_pairs(messages)
    world = WorldCache(token_budget=8000)
    control = ProjectionControlState()

    last_index = len(pairs) - 1
    for i, (tu, tr) in enumerate(pairs):
        name = tu.get("name", "")
        inp = tu.get("input", {}) or {}
        result = _result_text(tr)
        control.observe(_NAME_MAP.get(name, name), inp, result)
        if i < last_index:
            world.tick()
            _ingest(world, name, inp, result)

    return world, control, pairs


def sanitize_task(text: str) -> str:
    """Strip Claude Code boilerplate from the first user message, keep the task."""
    if not text:
        return ""

    import re

    t = str(text)

    for marker in ("Your task:", "Task:"):
        idx = t.find(marker)
        if idx >= 0:
            t = t[idx:]
            break

    t = re.sub(r"<system-reminder>.*?</system-reminder>", "", t, flags=re.DOTALL)
    t = re.sub(r"<claude_md>.*?</claude_md>", "", t, flags=re.DOTALL)
    t = re.sub(r"<[^>]+>", "", t)

    for marker in (
        "As you answer the user's questions, you can use the following context:",
        "Codebase and user instructions are shown below.",
        "IMPORTANT:",
    ):
        idx = t.find(marker)
        if idx >= 0 and idx < 200:
            t = t[idx + len(marker):]

    t = "\n".join(line.rstrip() for line in t.splitlines() if line.strip())
    return t.strip()[:1200]


# Anthropic validates subscription (OAuth) requests server-side and rejects any
# whose system prompt does not *begin* with this exact sentence. Claude Code
# always sends it as the first system block; when the proxy fronts real Claude
# we must preserve it, or every request comes back as an empty parse error.
CLAUDE_CODE_IDENTITY = "You are Claude Code, Anthropic's official CLI for Claude."


def _claude_identity_block(orig_system):
    """Return the required Claude Code identity system block.

    Preserves the original first block verbatim (keeping its cache_control)
    when Claude Code supplied it; otherwise synthesizes a minimal one.
    """
    if isinstance(orig_system, list):
        for blk in orig_system:
            if isinstance(blk, dict) and str(blk.get("text", "")).startswith(
                "You are Claude Code"
            ):
                return blk
    return {"type": "text", "text": CLAUDE_CODE_IDENTITY}


def _build_system(orig_system, preserve_claude_identity: bool,
                  cache_prefix: bool = False):
    """Build the projected system prompt.

    * Ollama path (default): one lean string — smallest possible context.
    * Native Claude path: an array whose FIRST block is the server-validated
      Claude Code identity sentence, followed by our projection contract.

    When ``cache_prefix`` is set (native Anthropic only) a single
    ``cache_control`` breakpoint is placed on the contract block, so the
    whole stable system prompt is cached after the first turn.
    """
    if not preserve_claude_identity:
        return PROJECTION_SYSTEM
    identity = _strip_cc(_claude_identity_block(orig_system))
    contract = {"type": "text", "text": PROJECTION_SYSTEM}
    if cache_prefix:
        contract = _with_cc(contract)
    return [identity, contract]


def _filter_tools(tools: Optional[list], keep: set,
                  cache_last: bool = False) -> Optional[list]:
    if not tools:
        return tools
    filtered = [t for t in tools if isinstance(t, dict) and t.get("name") in keep]
    filtered = filtered or tools[:4]
    # Strip inherited breakpoints, then (native path) cache the entire tool
    # block via a single marker on the last definition — tools never change.
    filtered = [_strip_cc(tool) for tool in filtered]
    if cache_last and filtered:
        filtered[-1] = _with_cc(filtered[-1])
    return filtered


def project_payload(payload: dict, keep_tools: Optional[set] = None,
                    preserve_claude_identity: bool = False,
                    cache_prefix: Optional[bool] = None) -> dict:
    """Project a Claude Code Anthropic Messages payload into constant space.

    Steps:
      1. Replace Claude Code's ~10 KB system prompt with :data:`PROJECTION_SYSTEM`.
      2. Strip the tool list down to :data:`DEFAULT_KEEP_TOOLS`.
      3. Rebuild the messages array from the durable world (every prior file
         read / command run as a native, correctly-paired tool exchange) plus
         an ``<operational_memory>`` block and the most recent live tool pair.

    The model therefore receives the full *progression* of its work in valid
    Anthropic format, never a single frozen pair — which is what kept small
    models looping. The model's response uses Claude Code tool names
    (``Read`` / ``Bash`` / ``Write`` / ``Edit``) so Claude Code can execute it.
    """
    keep = keep_tools if keep_tools is not None else DEFAULT_KEEP_TOOLS
    messages = payload.get("messages") or []

    # Anthropic prompt caching only helps the native Claude path; default it
    # on there and off for Ollama (which ignores cache_control).
    if cache_prefix is None:
        cache_prefix = preserve_claude_identity

    # 1 + 2: always swap the system prompt and shrink the tool list.
    payload["system"] = _build_system(payload.get("system"),
                                      preserve_claude_identity,
                                      cache_prefix=cache_prefix)
    filtered_tools = _filter_tools(payload.get("tools"), keep,
                                   cache_last=cache_prefix)
    if filtered_tools:
        payload["tools"] = filtered_tools
    else:
        # Never emit ``"tools": null``. The interactive Claude Code TUI fires
        # lightweight requests (conversation title, topic detection, quota
        # checks) that carry no tools; ``_filter_tools`` returns ``None`` for
        # those and assigning it would add ``"tools": null`` — which Anthropic
        # rejects with "tools: Input should be a valid array". Drop the key
        # (and any now-orphaned ``tool_choice``) so the request stays valid.
        payload.pop("tools", None)
        payload.pop("tool_choice", None)

    goal = sanitize_task(_extract_text(messages[0])) if messages else ""

    # First turn: nothing to project yet — just send the cleaned task.
    if len(messages) < 2:
        if messages:
            block = {"type": "text", "text": goal}
            if cache_prefix:
                block = _with_cc(block)
            payload["messages"] = [{"role": "user", "content": [block]}]
        return payload

    world, control, pairs = build_world_from_messages(messages)

    last_tool_use: list = []
    last_tool_result: list = []
    if pairs:
        tu_block, tr_block = pairs[-1]
        last_tool_use = [tu_block]
        last_tool_result = [tr_block]

    payload["messages"] = generate_context(
        goal=goal,
        world=world,
        last_tool_use=last_tool_use,
        last_tool_result=last_tool_result,
        control_state=control.render(),
        cwd="",
        tools_dialect="claude",
        cache_prefix=cache_prefix,
    )
    return payload
