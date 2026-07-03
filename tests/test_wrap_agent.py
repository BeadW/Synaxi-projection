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
    _agents_target_dir,
    _bundled_agents,
    _finalize_claude_args,
    _install_agents,
    _uninstall_agents,
)


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


# --- bundled agents ---------------------------------------------------------

def test_bundled_agents_present():
    """The definitions we ship (and install at wrap time) must exist."""
    names = {p.name for p in _bundled_agents()}
    assert {"synaxi-worker.md", "synaxi-chat.md"} <= names


# --- _agent_available (honors CLAUDE_CONFIG_DIR) ----------------------------

def test_unknown_agent_not_available(tmp_path, monkeypatch):
    monkeypatch.setenv("CLAUDE_CONFIG_DIR", str(tmp_path))
    assert _agent_available("does-not-exist", cwd=tmp_path) is False


def test_empty_agent_not_available():
    assert _agent_available("") is False


def test_agent_available_after_install(tmp_path, monkeypatch):
    """Installing the bundle makes --agent injection light up."""
    monkeypatch.setenv("CLAUDE_CONFIG_DIR", str(tmp_path))
    assert _agent_available(DEFAULT_AGENT, cwd=tmp_path) is False
    _install_agents(_agents_target_dir())
    assert _agent_available(DEFAULT_AGENT, cwd=tmp_path) is True
    assert _agent_available("synaxi-worker", cwd=tmp_path) is True


# --- install / uninstall lifecycle ------------------------------------------

def test_install_creates_files_and_uninstall_prunes(tmp_path):
    target = tmp_path / "cfg" / ".claude" / "agents"
    manifest = _install_agents(target)

    installed = {Path(r["path"]).name for r in manifest["agents"]}
    assert {"synaxi-worker.md", "synaxi-chat.md"} <= installed
    for r in manifest["agents"]:
        assert Path(r["path"]).exists()
    # Worker file must carry the sentinel or the proxy gate never fires.
    assert "SYNAXI-PROJECTION-WORKER" in (target / "synaxi-worker.md").read_text()

    _uninstall_agents(manifest)
    for r in manifest["agents"]:
        assert not Path(r["path"]).exists()
    # Directories we created are pruned back out; tmp_path itself remains.
    assert not target.exists()
    assert not (tmp_path / "cfg").exists()
    assert tmp_path.exists()


def test_uninstall_restores_preexisting_user_agent(tmp_path):
    """A user's own same-named agent is restored verbatim, never deleted."""
    target = tmp_path / "agents"
    target.mkdir(parents=True)
    user = target / "synaxi-worker.md"
    user.write_text("USER OWN CONTENT")

    manifest = _install_agents(target)
    # During the session our bundled content is active...
    assert "SYNAXI-PROJECTION-WORKER" in user.read_text()

    _uninstall_agents(manifest)
    # ...and afterwards the original is put back, and the pre-existing dir kept.
    assert user.read_text() == "USER OWN CONTENT"
    assert target.exists()


def test_uninstall_is_idempotent_and_tolerant(tmp_path):
    target = tmp_path / "agents"
    manifest = _install_agents(target)
    _uninstall_agents(manifest)
    _uninstall_agents(manifest)          # second call: no-op, no exception
    _uninstall_agents(None)              # empty inputs tolerated
    _uninstall_agents({})
    _uninstall_agents({"agents": [], "created_dirs": []})
    assert not target.exists()
