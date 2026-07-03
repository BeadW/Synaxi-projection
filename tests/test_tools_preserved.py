"""Projection must keep every tool the client defines (normal use).

Projection compresses the growing *message history*, not the fixed tool block —
so it must not silently strip tools the user actually has. Earlier the default
trimmed the request down to a hard-coded ``DEFAULT_KEEP_TOOLS`` set (Read/Write/
Edit/Bash + a few aliases), which removed Grep/Glob/TodoWrite/WebFetch and any
MCP tools in normal ``wrap claude`` use. These tests pin the contract that the
full toolset survives by default, while an explicit ``keep_tools`` set still
trims for a controlled benchmark.
"""
from __future__ import annotations

from synaxi_projection.projection import DEFAULT_KEEP_TOOLS, project_payload


def _payload_with_tools(names):
    return {
        "model": "claude-sonnet-4-5",
        "max_tokens": 256,
        "system": [{"type": "text",
                    "text": "You are Claude Code, Anthropic's official CLI for Claude."}],
        "tools": [{"name": n, "input_schema": {"type": "object"}} for n in names],
        "messages": [{"role": "user", "content": "make the tests pass"}],
    }


def _tool_names(payload):
    return [t.get("name") for t in payload.get("tools") or []]


def test_native_keeps_all_tools_including_non_default_ones():
    names = ["Read", "Bash", "Grep", "Glob", "TodoWrite", "WebFetch",
             "mcp__github__create_issue"]
    out = project_payload(_payload_with_tools(names), preserve_claude_identity=True)
    # Every tool survives — including the ones the old keep-set would have dropped.
    assert _tool_names(out) == names
    dropped_before = [n for n in names if n not in DEFAULT_KEEP_TOOLS]
    assert dropped_before, "sanity: fixture must include tools outside the old keep set"
    for n in dropped_before:
        assert n in _tool_names(out), f"{n} must not be stripped in normal use"


def test_ollama_path_also_keeps_all_tools_by_default():
    names = ["Read", "Bash", "Grep", "mcp__foo__bar"]
    out = project_payload(_payload_with_tools(names), preserve_claude_identity=False)
    assert _tool_names(out) == names


def test_explicit_keep_tools_still_trims_for_benchmarking():
    names = ["Read", "Bash", "Grep", "Glob", "TodoWrite"]
    out = project_payload(
        _payload_with_tools(names),
        keep_tools={"Read", "Bash"},
        preserve_claude_identity=True,
    )
    assert set(_tool_names(out)) == {"Read", "Bash"}


def test_explicit_keep_with_no_matches_keeps_all_rather_than_empty():
    names = ["Grep", "Glob", "TodoWrite"]
    out = project_payload(
        _payload_with_tools(names),
        keep_tools={"NonExistentTool"},
        preserve_claude_identity=True,
    )
    # Never trim to an empty/arbitrary subset just because nothing matched.
    assert _tool_names(out) == names


def test_native_caches_the_last_tool_only():
    names = ["Read", "Bash", "Grep", "Glob"]
    out = project_payload(_payload_with_tools(names), preserve_claude_identity=True)
    tools = out["tools"]
    # Exactly one cache breakpoint on the tool block, on its final entry, so the
    # whole (byte-stable) block sits behind a single marker.
    marked = [i for i, t in enumerate(tools) if "cache_control" in t]
    assert marked == [len(tools) - 1]
