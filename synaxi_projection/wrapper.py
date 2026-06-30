"""
synaxi_projection.wrapper
~~~~~~~~~~~~~~~~~~~~~~~~~
Wrap Claude Code with the Synaxi projection proxy — Headroom-style.

How it works (same as Headroom):
  1. Start a local proxy on http://127.0.0.1:\<port\>
  2. Write ANTHROPIC_BASE_URL into .claude/settings.local.json so ALL
     Claude Code sessions (including daemon-spawned workers) route through it.
  3. Launch `claude` as a subprocess with the env var also set directly.
  4. On exit: restore settings.local.json and stop the proxy.

Point at Ollama: pass upstream="http://127.0.0.1:11434"
"""
from __future__ import annotations

import json
import os
import shutil
import subprocess
import time
from pathlib import Path
from typing import Optional

from synaxi_projection.proxy import DEFAULT_PORT, is_proxy_running, start_proxy, stop_proxy

STATE_DIR = Path.home() / ".synaxi-projection"
STATE_FILE = STATE_DIR / "state.json"


def _load_state() -> dict:
    if not STATE_FILE.exists():
        return {}
    try:
        return json.loads(STATE_FILE.read_text())
    except Exception:
        return {}


def _save_state(state: dict) -> None:
    STATE_DIR.mkdir(parents=True, exist_ok=True)
    STATE_FILE.write_text(json.dumps(state, indent=2))


def _write_base_url(proxy_url: str, settings_path: Path) -> Optional[str]:
    """Inject ANTHROPIC_BASE_URL into a Claude settings file. Returns previous value."""
    settings_path.parent.mkdir(parents=True, exist_ok=True)
    payload: dict = {}
    if settings_path.exists():
        try:
            payload = json.loads(settings_path.read_text())
        except Exception:
            payload = {}
    if not isinstance(payload, dict):
        payload = {}
    env_map = dict(payload.get("env") or {}) if isinstance(payload.get("env"), dict) else {}
    previous = env_map.get("ANTHROPIC_BASE_URL")
    env_map["ANTHROPIC_BASE_URL"] = proxy_url
    env_map.setdefault("ENABLE_TOOL_SEARCH", "true")  # keep deferred tool schemas (Headroom #746)
    payload["env"] = env_map
    settings_path.write_text(json.dumps(payload, indent=2) + "\n")
    return previous


def _restore_base_url(previous: Optional[str], settings_path: Path) -> None:
    if not settings_path.exists():
        return
    try:
        payload = json.loads(settings_path.read_text())
    except Exception:
        return
    if not isinstance(payload, dict):
        return
    env_map = payload.get("env")
    if not isinstance(env_map, dict):
        return
    if previous is None:
        env_map.pop("ANTHROPIC_BASE_URL", None)
        env_map.pop("ENABLE_TOOL_SEARCH", None)
    else:
        env_map["ANTHROPIC_BASE_URL"] = previous
    if env_map:
        payload["env"] = env_map
    else:
        payload.pop("env", None)
    if payload:
        settings_path.write_text(json.dumps(payload, indent=2) + "\n")
    else:
        settings_path.unlink(missing_ok=True)


def wrap_claude(
    upstream: str = "https://api.anthropic.com",
    port: int = DEFAULT_PORT,
    proxy_url: Optional[str] = None,
    claude_args: tuple = (),
    no_proxy: bool = False,
) -> dict:
    """
    Start proxy, write settings.local.json, launch claude, restore on exit.
    Raises SystemExit with claude's return code.
    """
    claude_bin = shutil.which("claude")
    if not claude_bin:
        raise RuntimeError("'claude' not found in PATH. Install Claude Code first.")

    effective_proxy_url = proxy_url or f"http://127.0.0.1:{port}"

    proxy_proc = None
    if no_proxy:
        if not is_proxy_running(port):
            raise RuntimeError(f"--no-proxy: no proxy running on port {port}")
    else:
        proxy_proc = start_proxy(port=port, upstream=upstream)

    settings_path = Path.cwd() / ".claude" / "settings.local.json"
    saved_base_url = _write_base_url(effective_proxy_url, settings_path)

    _save_state({
        "wrapped": True,
        "proxy_url": effective_proxy_url,
        "upstream": upstream,
        "port": port,
        "settings_path": str(settings_path),
        "saved_base_url": saved_base_url,
        "wrapped_at": int(time.time()),
    })

    env = os.environ.copy()
    env["ANTHROPIC_BASE_URL"] = effective_proxy_url
    env["ENABLE_TOOL_SEARCH"] = "true"

    try:
        result = subprocess.run([claude_bin, *claude_args], env=env)
        exit_code = result.returncode
    except KeyboardInterrupt:
        exit_code = 130
    finally:
        _restore_base_url(saved_base_url, settings_path)
        stop_proxy(proxy_proc)
        _save_state({"wrapped": False, "unwrapped_at": int(time.time())})

    raise SystemExit(exit_code)


def unwrap_claude() -> dict:
    """Cleanup: remove ANTHROPIC_BASE_URL from settings.local.json."""
    st = _load_state()
    settings_path = Path(st.get("settings_path", str(Path.cwd() / ".claude" / "settings.local.json")))
    _restore_base_url(st.get("saved_base_url"), settings_path)
    _save_state({"wrapped": False, "unwrapped_at": int(time.time())})
    return {"restored": True, "settings_path": str(settings_path)}


def status() -> dict:
    st = _load_state()
    port = st.get("port", DEFAULT_PORT)
    return {
        "wrapped": bool(st.get("wrapped")),
        "proxy_running": is_proxy_running(port),
        "proxy_url": st.get("proxy_url"),
        "upstream": st.get("upstream"),
        "which_claude": shutil.which("claude"),
        "settings_path": st.get("settings_path"),
        "state_file": str(STATE_FILE),
    }


def doctor() -> dict:
    st = status()
    checks = {
        "claude_in_path": bool(st.get("which_claude")),
        "proxy_running": st["proxy_running"],
        "state_file_exists": STATE_FILE.exists(),
    }
    sp = st.get("settings_path")
    if sp:
        try:
            payload = json.loads(Path(sp).read_text())
            checks["base_url_set"] = (
                payload.get("env", {}).get("ANTHROPIC_BASE_URL") == st.get("proxy_url")
            )
        except Exception:
            checks["base_url_set"] = False
    ok = checks["claude_in_path"]
    return {"ok": ok, "checks": checks, "status": st}
