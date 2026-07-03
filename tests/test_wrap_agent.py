"""Wrapper agent injection: default to the slim chat orchestrator, safely.

`wrap claude` now defaults the interactive session to the `synaxi-chat`
orchestrator (which delegates coding to the projected `synaxi-worker`). These
tests pin the pure arg-building logic — that the default is injected only when
the agent exists on disk, never overrides an explicit user choice, and can be
turned off — without launching Claude Code.
"""
from __future__ import annotations

from pathlib import Path

from synaxi_projection.wrapper import (
    DEFAULT_AGENT,
    _agent_available,
    _finalize_claude_args,
)

REPO = Path(__file__).resolve().parent.parent


# --- _finalize_claude_args (pure) -------------------------------------------

def test_agent_injected_when_available():
    out = _finalize_claude_args((), model="", agent="synaxi-chat",
                                agent_available=True)
    assert out == ["--agent", "synaxi-chat"]


def test_agent_not_injected_when_unavailable():
    """Missing definition -> no --agent, so Claude Code doesn't error at start."""
    out = _finalize_claude_args((), model="", agent="synaxi-chat",
                                agent_available=False)
    assert out == []


def test_empty_agent_skips_injection():
    """--no-agent maps to agent='' -> plain Claude Code."""
    out = _finalize_claude_args((), model="", agent="",
                                agent_available=True)
    assert out == []


def test_user_agent_choice_is_not_overridden():
    out = _finalize_claude_args(("--agent", "my-own"), model="",
                                agent="synaxi-chat", agent_available=True)
    assert out.count("--agent") == 1
    assert "synaxi-chat" not in out


def test_model_and_agent_both_injected():
    out = _finalize_claude_args((), model="qwen2.5-coder:7b",
                                agent="synaxi-chat", agent_available=True)
    assert "--model" in out and "qwen2.5-coder:7b" in out
    assert "--agent" in out and "synaxi-chat" in out


def test_user_model_choice_is_not_overridden():
    out = _finalize_claude_args(("--model", "opus"), model="qwen2.5-coder:7b",
                                agent="", agent_available=False)
    assert out == ["--model", "opus"]


def test_existing_user_args_preserved_after_defaults():
    out = _finalize_claude_args(("--resume",), model="haiku",
                                agent="synaxi-chat", agent_available=True)
    # user arg still present; defaults prepended
    assert out[-1] == "--resume"
    assert "--agent" in out and "--model" in out


# --- _agent_available (touches disk) ----------------------------------------

def test_default_agents_exist_in_this_repo():
    """The agents we ship must be discoverable from the repo root."""
    assert _agent_available(DEFAULT_AGENT, cwd=REPO) is True
    assert _agent_available("synaxi-worker", cwd=REPO) is True


def test_unknown_agent_not_available(tmp_path):
    assert _agent_available("does-not-exist", cwd=tmp_path) is False


def test_empty_agent_not_available():
    assert _agent_available("", cwd=REPO) is False
