"""Worker-subagent gate: project only the stamped worker, pass everything else.

The proxy no longer projects every ``/v1/messages`` request. Projection is gated
on a sentinel that the ``synaxi-worker`` subagent carries in its system prompt,
so the tool-free chat orchestrator, ``/init``, and lightweight sidecars flow
through untouched while the worker's agentic turns are compressed into constant
space. These tests pin the detection logic and guard that the agent markdown
files and the code constant never drift apart.
"""
from __future__ import annotations

from synaxi_projection.projection import (
    PROJECTION_SYSTEM,
    WORKER_SENTINEL,
    is_worker_payload,
    project_payload,
    system_text,
)
from synaxi_projection.wrapper import _BUNDLED_AGENTS_DIR

AGENTS = _BUNDLED_AGENTS_DIR


def _worker_system_list():
    """A Claude-Code-shaped ``system`` array for the worker: identity block +
    the subagent body (which carries the sentinel)."""
    return [
        {"type": "text",
         "text": "You are Claude Code, Anthropic's official CLI for Claude."},
        {"type": "text",
         "text": f"{WORKER_SENTINEL}\n\nYou are an autonomous coding agent."},
    ]


# --- system_text ------------------------------------------------------------

def test_system_text_flattens_string():
    assert system_text("hello world") == "hello world"


def test_system_text_flattens_block_list():
    flat = system_text([
        {"type": "text", "text": "alpha"},
        {"type": "text", "text": "beta"},
    ])
    assert "alpha" in flat and "beta" in flat


def test_system_text_handles_none_and_junk():
    assert system_text(None) == ""
    assert system_text(123) == ""


# --- is_worker_payload ------------------------------------------------------

def test_sentinel_detected_in_string_system():
    payload = {"system": f"prefix {WORKER_SENTINEL} suffix", "messages": []}
    assert is_worker_payload(payload) is True


def test_sentinel_detected_in_list_system():
    payload = {"system": _worker_system_list(), "messages": []}
    assert is_worker_payload(payload) is True


def test_plain_claude_request_is_not_worker():
    payload = {
        "system": [{"type": "text",
                    "text": "You are Claude Code, Anthropic's official CLI for Claude."}],
        "messages": [{"role": "user", "content": "hey"}],
    }
    assert is_worker_payload(payload) is False


def test_missing_or_empty_system_is_not_worker():
    assert is_worker_payload({"messages": []}) is False
    assert is_worker_payload({}) is False
    assert is_worker_payload({"system": ""}) is False


def test_non_dict_payload_is_not_worker():
    assert is_worker_payload(None) is False  # type: ignore[arg-type]
    assert is_worker_payload("nope") is False  # type: ignore[arg-type]


# --- agent files stay in sync with the code constant ------------------------

def test_worker_agent_file_carries_sentinel():
    """If the .md body and the code constant drift, the gate silently never
    fires in production — so pin them together."""
    md = (AGENTS / "synaxi-worker.md").read_text()
    assert WORKER_SENTINEL in md


def test_chat_agent_file_has_no_sentinel():
    """The chat orchestrator must NOT be projected: its system prompt must not
    carry the worker sentinel, or its conversational turns would be collapsed."""
    md = (AGENTS / "synaxi-chat.md").read_text()
    assert WORKER_SENTINEL not in md


# --- AskUserQuestion is a main-session-only tool ----------------------------
# It depends on the conversation UI, so Claude Code blocks it for spawned
# subagents even when listed in ``tools``. synaxi-chat runs as the *main* agent
# (``--agent synaxi-chat``), so it may use it; the headless worker never can.

def test_chat_agent_grants_ask_user_question():
    """The chat orchestrator owns the UI and grills with structured choices, so
    it must keep AskUserQuestion in its tool allowlist."""
    md = (AGENTS / "synaxi-chat.md").read_text()
    assert "AskUserQuestion" in md


def test_worker_agent_has_no_ask_user_question():
    """The worker is a headless subagent with no conversation UI: granting it a
    UI-gated tool would be dead weight (and misleading), so keep it out."""
    md = (AGENTS / "synaxi-worker.md").read_text()
    assert "AskUserQuestion" not in md


# --- end-to-end: a worker payload projects to constant space ----------------

def test_worker_payload_projects_to_constant_system():
    """When the gate lets a worker payload through, projection swaps its body for
    the lean projection system prompt (Ollama path)."""
    payload = {
        "system": f"{WORKER_SENTINEL}\n\nYou are an autonomous coding agent.",
        "tools": [{"name": "Read", "input_schema": {"type": "object"}}],
        "messages": [{"role": "user", "content": "Your task: make the tests pass."}],
    }
    assert is_worker_payload(payload) is True
    out = project_payload(dict(payload), preserve_claude_identity=False)
    assert out["system"] == PROJECTION_SYSTEM
