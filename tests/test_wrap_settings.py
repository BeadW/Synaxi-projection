"""Wrapper settings: ANTHROPIC_AUTH_TOKEN must track the real upstream.

Regression for the "Invalid bearer token" failure: `_write_base_url` keyed the
auth token off ``proxy_url`` (always the local proxy, never api.anthropic.com),
so *every* wrap — native included — wrote ``ANTHROPIC_AUTH_TOKEN=ollama`` into
``.claude/settings.local.json``. Claude Code then sent ``Authorization: Bearer
ollama`` to the real Anthropic API and every request 401'd. Switching from a
prior Ollama wrap to a native wrap must therefore *clear* the placeholder token,
and unwrap must remove it entirely.
"""
from __future__ import annotations

import json

from synaxi_projection.wrapper import _restore_base_url, _write_base_url

PROXY = "http://127.0.0.1:8787"
NATIVE = "https://api.anthropic.com"
OLLAMA = "http://127.0.0.1:11434"


def _env(settings_path):
    return json.loads(settings_path.read_text())["env"]


def test_native_wrap_sets_no_auth_token(tmp_path):
    sp = tmp_path / ".claude" / "settings.local.json"
    _write_base_url(PROXY, sp, upstream=NATIVE)
    env = _env(sp)
    assert env["ANTHROPIC_BASE_URL"] == PROXY
    # Native must fall back to Claude Code's own OAuth subscription auth.
    assert "ANTHROPIC_AUTH_TOKEN" not in env


def test_ollama_wrap_sets_placeholder_auth_token(tmp_path):
    sp = tmp_path / ".claude" / "settings.local.json"
    _write_base_url(PROXY, sp, upstream=OLLAMA)
    assert _env(sp)["ANTHROPIC_AUTH_TOKEN"] == "ollama"


def test_switching_ollama_to_native_clears_stale_token(tmp_path):
    """The exact failure: an Ollama wrap followed by a native wrap."""
    sp = tmp_path / ".claude" / "settings.local.json"
    _write_base_url(PROXY, sp, upstream=OLLAMA)
    assert _env(sp)["ANTHROPIC_AUTH_TOKEN"] == "ollama"  # poisoned

    _write_base_url(PROXY, sp, upstream=NATIVE)
    assert "ANTHROPIC_AUTH_TOKEN" not in _env(sp)  # cleaned


def test_default_upstream_is_native_and_tokenless(tmp_path):
    sp = tmp_path / ".claude" / "settings.local.json"
    _write_base_url(PROXY, sp)  # default upstream = native
    assert "ANTHROPIC_AUTH_TOKEN" not in _env(sp)


def test_unwrap_removes_auth_token(tmp_path):
    sp = tmp_path / ".claude" / "settings.local.json"
    _write_base_url(PROXY, sp, upstream=OLLAMA)
    assert _env(sp)["ANTHROPIC_AUTH_TOKEN"] == "ollama"

    # previous=None -> nothing was set before wrapping, so unwrap clears our keys.
    _restore_base_url(None, sp)
    if sp.exists():
        env = json.loads(sp.read_text()).get("env", {})
        assert "ANTHROPIC_AUTH_TOKEN" not in env
        assert "ANTHROPIC_BASE_URL" not in env


def test_wrap_preserves_unrelated_env_keys(tmp_path):
    sp = tmp_path / ".claude" / "settings.local.json"
    sp.parent.mkdir(parents=True)
    sp.write_text(json.dumps({"env": {"MY_CUSTOM": "keep-me"}}))
    _write_base_url(PROXY, sp, upstream=NATIVE)
    env = _env(sp)
    assert env["MY_CUSTOM"] == "keep-me"
    assert env["ANTHROPIC_BASE_URL"] == PROXY
