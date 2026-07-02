"""Cache-aware projection: breakpoint placement.

Verifies that ``project_payload`` places Anthropic ``cache_control`` breakpoints
on exactly the byte-stable segments (system contract, last tool, last durable
world observation) on the native Claude path, and none at all on the Ollama
path. See ``docs/RESULTS.md`` for why breakpoint placement is what earns the
prompt-cache cost win.
"""
from __future__ import annotations

from synaxi_projection.projection import project_payload


def _make_payload():
    """A synthetic Claude Code payload: identity + big system, 5 tools, 3 pairs."""
    return {
        "model": "claude-haiku-4-5",
        "system": [
            {"type": "text",
             "text": "You are Claude Code, Anthropic's official CLI for Claude."},
            {"type": "text", "text": "BIG CLAUDE CODE SYSTEM PROMPT " * 200,
             "cache_control": {"type": "ephemeral"}},
        ],
        "tools": [
            {"name": "Read", "input_schema": {"type": "object"}},
            {"name": "Write", "input_schema": {"type": "object"}},
            {"name": "Edit", "input_schema": {"type": "object"}},
            {"name": "Bash", "input_schema": {"type": "object"}},
            {"name": "Glob", "input_schema": {"type": "object"},
             "cache_control": {"type": "ephemeral"}},
        ],
        "messages": [
            {"role": "user", "content": "Your task: make the tests pass."},
            {"role": "assistant", "content": [
                {"type": "tool_use", "id": "t1", "name": "Bash",
                 "input": {"command": "ls"}}]},
            {"role": "user", "content": [
                {"type": "tool_result", "tool_use_id": "t1",
                 "content": "a.py test_a.py"}]},
            {"role": "assistant", "content": [
                {"type": "tool_use", "id": "t2", "name": "Read",
                 "input": {"file_path": "a.py"}}]},
            {"role": "user", "content": [
                {"type": "tool_result", "tool_use_id": "t2",
                 "content": "def f(): return 1"}]},
            {"role": "assistant", "content": [
                {"type": "tool_use", "id": "t3", "name": "Bash",
                 "input": {"command": "pytest"}}]},
            {"role": "user", "content": [
                {"type": "tool_result", "tool_use_id": "t3", "content": "1 failed",
                 "cache_control": {"type": "ephemeral"}}]},
        ],
    }


def _count_breakpoints(payload) -> int:
    n = 0
    sysb = payload["system"]
    if isinstance(sysb, list):
        n += sum(1 for b in sysb if isinstance(b, dict) and "cache_control" in b)
    for t in payload.get("tools") or []:
        n += 1 if isinstance(t, dict) and "cache_control" in t else 0
    for m in payload["messages"]:
        c = m.get("content")
        if isinstance(c, list):
            n += sum(1 for b in c if isinstance(b, dict) and "cache_control" in b)
    return n


def test_native_has_exactly_three_breakpoints_on_stable_segments():
    p = project_payload(_make_payload(), preserve_claude_identity=True)

    # Exactly 3 markers, inside Anthropic's budget of 4.
    assert _count_breakpoints(p) == 3

    # 1) system contract (block 2) cached; identity (block 1) is NOT.
    assert isinstance(p["system"], list)
    assert "cache_control" not in p["system"][0]
    assert "cache_control" in p["system"][1]

    # 2) the tool list is cached via a single marker on its last entry.
    assert "cache_control" in p["tools"][-1]

    # 3) the volatile live tail (final message) carries NO breakpoint.
    last = p["messages"][-1]["content"]
    assert not any(isinstance(b, dict) and "cache_control" in b for b in last)

    # operational memory must be relocated off msg[0] so the prefix stays stable.
    assert "operational_memory" not in p["messages"][0]["content"][0]["text"]


def test_ollama_path_has_no_breakpoints():
    p = project_payload(_make_payload(), preserve_claude_identity=False)
    assert _count_breakpoints(p) == 0
    # Ollama uses the lean string system prompt, not a block array.
    assert isinstance(p["system"], str)
