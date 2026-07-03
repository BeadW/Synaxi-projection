"""Operational memory must reach the worker as trusted context, not injection.

Operational memory is the core of projection: the agent's own lessons, distilled
from its earlier tool results, carried forward every turn. The native projection
worker (a full Claude model) refused it when we delivered it as a bare
``<operational_memory>`` block with an "Apply this memory..." imperative appended
after a tool_result — that is textbook prompt-injection shape.

The fix delivers it via ``<system-reminder>`` — Claude Code's own convention for
injecting trusted, dynamic in-band context — kept in the volatile tail (after
the cache breakpoint) so the cached world prefix stays byte-stable. These tests
pin that the memory still reaches the worker, now in trusted form.
"""
from __future__ import annotations

from synaxi_projection.projection import (
    WorldCache,
    generate_context,
    project_payload,
)

_INJECTION_MARKERS = ("<operational_memory>", "Apply this memory when choosing tools")


def _tail_text(msgs: list) -> str:
    """Concatenate the text blocks of the final (live) user message."""
    last = msgs[-1]
    return " ".join(
        b.get("text", "")
        for b in (last.get("content") or [])
        if isinstance(b, dict) and b.get("type") == "text"
    )


def _all_injected_text(msgs: list) -> str:
    """All text-block text across the projected messages (excludes tool_result
    payloads, which are separate blocks)."""
    out = []
    for m in msgs:
        for b in (m.get("content") or []):
            if isinstance(b, dict) and b.get("type") == "text":
                out.append(b.get("text", ""))
    return "\n".join(out)


# --- generate_context: the memory tail is a <system-reminder> ---------------

def test_memory_rendered_as_system_reminder_not_injection():
    msgs = generate_context(
        goal="Your task: fix it",
        world=WorldCache(),
        last_tool_use=[{"type": "tool_use", "id": "t1", "name": "Bash",
                        "input": {"command": "pytest"}}],
        last_tool_result=[{"type": "tool_result", "tool_use_id": "t1",
                           "content": "1 failed"}],
        control_state="- Use `python3` (not `python`) in this sandbox.",
        tools_dialect="claude",
    )
    tail = _tail_text(msgs)
    # Delivered as trusted in-band context...
    assert "<system-reminder>" in tail
    assert "</system-reminder>" in tail
    # ...carrying the actual distilled lesson to the worker...
    assert "python3" in tail
    assert "your own operational memory" in tail.lower()
    # ...and NOT in the old injection shape.
    for marker in _INJECTION_MARKERS:
        assert marker not in tail


def test_no_memory_means_no_reminder_block():
    msgs = generate_context(
        goal="Your task: fix it",
        world=WorldCache(),
        last_tool_use=[{"type": "tool_use", "id": "t1", "name": "Bash",
                        "input": {"command": "pytest"}}],
        last_tool_result=[{"type": "tool_result", "tool_use_id": "t1",
                           "content": "ok"}],
        control_state="(none yet)",          # nothing learned yet
        tools_dialect="claude",
    )
    assert "<system-reminder>" not in _all_injected_text(msgs)


def test_runtime_notice_also_uses_system_reminder():
    msgs = generate_context(
        goal="Your task: fix it",
        world=WorldCache(),
        last_tool_use=[],
        last_tool_result=[],
        runtime_notice="Emit exactly one real tool call.",
        tools_dialect="claude",
    )
    text = _all_injected_text(msgs)
    assert "<system-reminder>" in text
    assert "Emit exactly one real tool call." in text
    assert "<runtime_reminder>" not in text


# --- project_payload: end-to-end, memory learned from history reaches worker -

def test_learned_memory_reaches_worker_as_system_reminder():
    """A real failure in history distills into memory that the projected payload
    carries forward — now inside a <system-reminder>, not an injection block."""
    history = [
        {"role": "user", "content": "Your task: make the tests pass"},
        {"role": "assistant", "content": [
            {"type": "tool_use", "id": "a", "name": "Bash",
             "input": {"command": "python foo.py"}}]},
        {"role": "user", "content": [
            {"type": "tool_result", "tool_use_id": "a",
             "content": "python: command not found"}]},
        {"role": "assistant", "content": [
            {"type": "tool_use", "id": "b", "name": "Read",
             "input": {"file_path": "foo.py"}}]},
        {"role": "user", "content": [
            {"type": "tool_result", "tool_use_id": "b", "content": "print('hi')"}]},
    ]
    payload = {
        "model": "claude-x",
        "system": "SYNAXI-PROJECTION-WORKER\nbody",
        "tools": [{"name": "Bash", "input_schema": {"type": "object"}}],
        "messages": history,
    }
    out = project_payload(dict(payload), preserve_claude_identity=False)
    injected = _all_injected_text(out["messages"])

    # The distilled lesson (use python3) reached the worker...
    assert "python3" in injected
    # ...as trusted context, not injection shape.
    assert "<system-reminder>" in injected
    for marker in _INJECTION_MARKERS:
        assert marker not in injected
