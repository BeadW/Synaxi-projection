"""
synaxi_projection.proxy
~~~~~~~~~~~~~~~~~~~~~~~~
Lifecycle helpers for the Synaxi projection proxy.

The proxy server itself lives in ``_proxy_server.py`` and is launched as a
standalone script (so it stays dependency-light). This module starts/stops that
server and exposes the canonical projection entrypoint for programmatic callers.

The projection transform is defined once in
:mod:`synaxi_projection.projection` and shared by every caller — the benchmark
agent loop, this module, and ``_proxy_server.py``.

Usage (programmatic):
    from synaxi_projection.proxy import start_proxy, stop_proxy
    proc = start_proxy(port=8787, upstream="http://127.0.0.1:11434", model="gemma4:latest")
    ...
    stop_proxy(proc)

Usage (CLI):
    python -m synaxi_projection.proxy --port 8787 --upstream http://127.0.0.1:11434
"""
from __future__ import annotations

import logging
import os
import signal
import subprocess
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path

from synaxi_projection.projection import project_payload

log = logging.getLogger("synaxi.proxy")

DEFAULT_PORT = 8787
PROXY_READY_TIMEOUT = 15  # seconds

_SERVER_MODULE = str(Path(__file__).parent / "_proxy_server.py")


# ---------------------------------------------------------------------------
# Projection transform (canonical engine — see synaxi_projection.projection)
# ---------------------------------------------------------------------------

def apply_projection(payload: dict) -> dict:
    """Apply constant-space context projection to an Anthropic messages payload.

    Thin wrapper around :func:`synaxi_projection.projection.project_payload`,
    the single source of truth shared with the benchmark loop and
    ``_proxy_server.py``.
    """
    return project_payload(payload)


# ---------------------------------------------------------------------------
# Process lifecycle
# ---------------------------------------------------------------------------

def _kill_port(port: int) -> None:
    """Kill any process already listening on ``port`` (avoids stale proxy reuse)."""
    try:
        result = subprocess.run(
            ["lsof", "-ti", f"tcp:{port}"],
            capture_output=True, text=True,
        )
        for pid_str in result.stdout.split():
            try:
                os.kill(int(pid_str), signal.SIGTERM)
            except Exception:
                pass
        if result.stdout.strip():
            time.sleep(0.5)  # give them time to die
    except Exception:
        pass


def start_proxy(
    port: int = DEFAULT_PORT,
    upstream: str = "https://api.anthropic.com",
    model: str = "",
    disable_projection: bool = False,
) -> subprocess.Popen:
    """Start the proxy in a background subprocess. Returns the Popen handle.

    The proxy is ready once its ``/health`` endpoint responds 200. Any stale
    process already bound to ``port`` is killed first.
    """
    _kill_port(port)

    env = os.environ.copy()
    env["SYNAXI_PORT"] = str(port)
    env["SYNAXI_UPSTREAM"] = upstream
    if model:
        env["SYNAXI_MODEL"] = model
    if disable_projection:
        env["SYNAXI_DISABLE_PROJECTION"] = "1"

    proc = subprocess.Popen(
        [sys.executable, _SERVER_MODULE],
        env=env,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
        start_new_session=True,
    )

    deadline = time.monotonic() + PROXY_READY_TIMEOUT
    while time.monotonic() < deadline:
        try:
            urllib.request.urlopen(f"http://127.0.0.1:{port}/health", timeout=1)
            return proc
        except Exception:
            if proc.poll() is not None:
                raise RuntimeError(f"Proxy process exited unexpectedly (code {proc.returncode})")
            time.sleep(0.2)

    proc.terminate()
    raise RuntimeError(f"Proxy on port {port} did not become ready within {PROXY_READY_TIMEOUT}s")


def stop_proxy(proc: "subprocess.Popen | None") -> None:
    if proc is None:
        return
    try:
        os.killpg(os.getpgid(proc.pid), signal.SIGTERM)
    except Exception:
        try:
            proc.terminate()
        except Exception:
            pass


def is_proxy_running(port: int = DEFAULT_PORT) -> bool:
    try:
        urllib.request.urlopen(f"http://127.0.0.1:{port}/health", timeout=1)
        return True
    except Exception:
        return False


# ---------------------------------------------------------------------------
# CLI entry point  (python -m synaxi_projection.proxy)
# ---------------------------------------------------------------------------

def main() -> None:
    import argparse

    parser = argparse.ArgumentParser(prog="synaxi-proxy")
    parser.add_argument("--port", type=int, default=DEFAULT_PORT)
    parser.add_argument("--upstream", default="https://api.anthropic.com",
                        help="Upstream API base URL (Anthropic or Ollama)")
    parser.add_argument("--model", default="",
                        help="Force the model name sent upstream (Ollama tag)")
    args = parser.parse_args()

    upstream = args.upstream.rstrip("/")
    proc = start_proxy(port=args.port, upstream=upstream, model=args.model)
    print(f"synaxi-proxy listening on http://127.0.0.1:{args.port} -> {upstream}", flush=True)
    try:
        proc.wait()
    except KeyboardInterrupt:
        stop_proxy(proc)


if __name__ == "__main__":
    main()
