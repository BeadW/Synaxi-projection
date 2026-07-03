"""Regression: projection must never emit ``"tools": null``.

The interactive Claude Code TUI fires lightweight requests (conversation
title, topic detection, quota checks) that carry *no* tools. Earlier,
``project_payload`` assigned ``_filter_tools(None) -> None`` straight back onto
the payload, producing ``"tools": null`` on the wire. Anthropic rejects that
with ``tools: Input should be a valid array`` — which broke ``wrap claude`` for
every no-tool request even though the benchmark path (always 4 tools) was fine.

The contract these tests pin down: after projection, ``tools`` is either a
non-empty list or *absent* — never JSON ``null`` — and an orphaned
``tool_choice`` is dropped alongside it.
"""
from __future__ import annotations

import json

from synaxi_projection.projection import project_payload


def _title_request():
    """A realistic no-tool Claude Code request (conversation-title style)."""
    return {
        "model": "claude-sonnet-4-5",
        "max_tokens": 512,
        "system": "You are Claude Code, Anthropic's official CLI for Claude.",
        "messages": [
            {"role": "user",
             "content": "Summarise this session in 5 words or fewer."},
        ],
    }


def _assert_tools_valid(payload):
    """``tools`` must be absent or a list — and never serialise to null."""
    assert payload.get("tools", []) is not None, "tools must never be None"
    if "tools" in payload:
        assert isinstance(payload["tools"], list)
    assert '"tools": null' not in json.dumps(payload)


def test_missing_tools_key_never_becomes_null_native():
    payload = _title_request()
    assert "tools" not in payload  # precondition: request carries no tools
    out = project_payload(payload, preserve_claude_identity=True)
    _assert_tools_valid(out)


def test_missing_tools_key_never_becomes_null_ollama():
    out = project_payload(_title_request(), preserve_claude_identity=False)
    _assert_tools_valid(out)


def test_empty_tools_list_never_becomes_null():
    payload = _title_request()
    payload["tools"] = []
    out = project_payload(payload, preserve_claude_identity=True)
    _assert_tools_valid(out)


def test_orphaned_tool_choice_is_dropped_when_no_tools():
    payload = _title_request()
    payload["tool_choice"] = {"type": "auto"}
    out = project_payload(payload, preserve_claude_identity=True)
    _assert_tools_valid(out)
    # tool_choice without tools is itself an invalid_request_error upstream.
    assert "tool_choice" not in out


def test_real_tool_request_still_projects_a_list():
    payload = _title_request()
    payload["messages"] = [{"role": "user", "content": "make the tests pass"}]
    payload["tools"] = [
        {"name": "Read", "input_schema": {"type": "object"}},
        {"name": "Bash", "input_schema": {"type": "object"}},
    ]
    out = project_payload(payload, preserve_claude_identity=True)
    assert isinstance(out["tools"], list) and out["tools"], "tools must survive"
    _assert_tools_valid(out)
