"""
synaxi_projection.proxy
~~~~~~~~~~~~~~~~~~~~~~~
Local MITM proxy that sits between Claude Code and the Anthropic API.

Claude Code is pointed at this proxy via ANTHROPIC_BASE_URL=http://127.0.0.1:<port>.
Every request is intercepted, the projection transform is applied to the
messages array, then the request is forwarded upstream (Anthropic or Ollama).

Usage (programmatic):
    from synaxi_projection.proxy import start_proxy, stop_proxy
    proc = start_proxy(port=8787, upstream="https://api.anthropic.com")
    ...
    stop_proxy(proc)

Usage (CLI):
    python -m synaxi_projection.proxy --port 8787
    python -m synaxi_projection.proxy --port 8787 --upstream http://127.0.0.1:11434
"""
from __future__ import annotations

import json
import logging
import os
import signal
import subprocess
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path
from typing import Optional

log = logging.getLogger("synaxi.proxy")

DEFAULT_PORT = 8787
PROXY_READY_TIMEOUT = 15  # seconds


# ---------------------------------------------------------------------------
# Projection transform
# ---------------------------------------------------------------------------

def apply_projection(payload: dict) -> dict:
    """
    Apply constant-space context projection to an Anthropic messages payload.

    The transform keeps the system prompt and the most recent N turns of the
    conversation verbatim and compresses older turns to a single summary
    block.  This mirrors what benchmark.py does inside the agent loop.

    Currently: pass-through (no compression yet) — correct wire format is
    preserved.  Replace the body of this function to add real compression.
    """
    # TODO: plug in real projection/compression here
    return payload


# ---------------------------------------------------------------------------
# Proxy server (pure stdlib — no fastapi/uvicorn dependency required)
# ---------------------------------------------------------------------------

_SERVER_SOURCE = '''
import http.server
import json
import os
import ssl
import sys
import urllib.error
import urllib.request

UPSTREAM = os.environ.get("SYNAXI_UPSTREAM", "https://api.anthropic.com")
PORT     = int(os.environ.get("SYNAXI_PORT", "8787"))


def _apply_projection(payload):
    """Pass-through; replace with real compression logic."""
    return payload


class ProxyHandler(http.server.BaseHTTPRequestHandler):
    def log_message(self, fmt, *args):
        pass  # silence default access log

    def _forward(self):
        length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(length) if length else b""

        # --- projection transform ---
        content_type = self.headers.get("Content-Type", "")
        if body and "application/json" in content_type:
            try:
                payload = json.loads(body)
                payload = _apply_projection(payload)
                body = json.dumps(payload).encode()
            except Exception:
                pass

        # Build upstream URL
        upstream_url = UPSTREAM.rstrip("/") + self.path

        req_headers = {}
        for key, val in self.headers.items():
            lo = key.lower()
            # Strip hop-by-hop headers
            if lo in ("host", "transfer-encoding", "connection", "content-length"):
                continue
            req_headers[key] = val
        if body:
            req_headers["Content-Length"] = str(len(body))

        req = urllib.request.Request(
            upstream_url,
            data=body or None,
            headers=req_headers,
            method=self.command,
        )

        try:
            ctx = None
            if upstream_url.startswith("https://"):
                ctx = ssl.create_default_context()
            with urllib.request.urlopen(req, context=ctx, timeout=600) as resp:
                resp_body = resp.read()
                self.send_response(resp.status)
                for key, val in resp.headers.items():
                    lo = key.lower()
                    if lo in ("transfer-encoding", "connection"):
                        continue
                    self.send_header(key, val)
                self.send_header("Content-Length", str(len(resp_body)))
                self.end_headers()
                self.wfile.write(resp_body)
        except urllib.error.HTTPError as e:
            resp_body = e.read()
            self.send_response(e.code)
            for key, val in e.headers.items():
                lo = key.lower()
                if lo in ("transfer-encoding", "connection"):
                    continue
                self.send_header(key, val)
            self.send_header("Content-Length", str(len(resp_body)))
            self.end_headers()
            self.wfile.write(resp_body)
        except Exception as exc:
            msg = json.dumps({"error": str(exc)}).encode()
            self.send_response(502)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(msg)))
            self.end_headers()
            self.wfile.write(msg)

    def do_GET(self):
        # Health endpoint
        if self.path in ("/health", "/livez", "/readyz"):
            body = b\'{"status":"ok"}\'
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
            return
        self._forward()

    def do_POST(self):   self._forward()
    def do_PUT(self):    self._forward()
    def do_DELETE(self): self._forward()
    def do_PATCH(self):  self._forward()


if __name__ == "__main__":
    server = http.server.HTTPServer(("127.0.0.1", PORT), ProxyHandler)
    print(f"synaxi-proxy listening on http://127.0.0.1:{PORT} -> {UPSTREAM}", flush=True)
    server.serve_forever()
'''


def start_proxy(
    port: int = DEFAULT_PORT,
    upstream: str = "https://api.anthropic.com",
) -> subprocess.Popen:
    """
    Start the proxy in a background subprocess. Returns the Popen handle.
    The proxy is ready once its /health endpoint responds 200.
    """
    env = os.environ.copy()
    env["SYNAXI_PORT"] = str(port)
    env["SYNAXI_UPSTREAM"] = upstream

    # Write server source to a temp file so we don't depend on the installed
    # package being importable from a subprocess (avoids import path issues).
    import tempfile
    tmp = tempfile.NamedTemporaryFile(
        mode="w", suffix=".py", delete=False, prefix="synaxi_proxy_"
    )
    tmp.write(_SERVER_SOURCE)
    tmp.flush()
    tmp.close()

    proc = subprocess.Popen(
        [sys.executable, tmp.name],
        env=env,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
        start_new_session=True,
    )

    # Wait for readiness
    deadline = time.monotonic() + PROXY_READY_TIMEOUT
    while time.monotonic() < deadline:
        try:
            urllib.request.urlopen(
                f"http://127.0.0.1:{port}/health", timeout=1
            )
            return proc
        except Exception:
            if proc.poll() is not None:
                raise RuntimeError(f"Proxy process exited unexpectedly (code {proc.returncode})")
            time.sleep(0.2)

    proc.terminate()
    raise RuntimeError(f"Proxy on port {port} did not become ready within {PROXY_READY_TIMEOUT}s")


def stop_proxy(proc: Optional[subprocess.Popen]) -> None:
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
    args = parser.parse_args()

    import http.server
    import ssl

    upstream = args.upstream.rstrip("/")

    def _apply_projection_inline(payload):
        return apply_projection(payload)

    class _Handler(http.server.BaseHTTPRequestHandler):
        def log_message(self, fmt, *args):
            pass

        def _forward(self):
            length = int(self.headers.get("Content-Length", 0))
            body = self.rfile.read(length) if length else b""
            content_type = self.headers.get("Content-Type", "")
            if body and "application/json" in content_type:
                try:
                    payload = json.loads(body)
                    payload = _apply_projection_inline(payload)
                    body = json.dumps(payload).encode()
                except Exception:
                    pass

            url = upstream + self.path
            req_headers = {
                k: v for k, v in self.headers.items()
                if k.lower() not in ("host", "transfer-encoding", "connection", "content-length")
            }
            if body:
                req_headers["Content-Length"] = str(len(body))

            req = urllib.request.Request(url, data=body or None, headers=req_headers, method=self.command)
            try:
                ctx = ssl.create_default_context() if url.startswith("https://") else None
                with urllib.request.urlopen(req, context=ctx, timeout=600) as resp:
                    rb = resp.read()
                    self.send_response(resp.status)
                    for k, v in resp.headers.items():
                        if k.lower() not in ("transfer-encoding", "connection"):
                            self.send_header(k, v)
                    self.send_header("Content-Length", str(len(rb)))
                    self.end_headers()
                    self.wfile.write(rb)
            except urllib.error.HTTPError as e:
                rb = e.read()
                self.send_response(e.code)
                for k, v in e.headers.items():
                    if k.lower() not in ("transfer-encoding", "connection"):
                        self.send_header(k, v)
                self.send_header("Content-Length", str(len(rb)))
                self.end_headers()
                self.wfile.write(rb)
            except Exception as exc:
                msg = json.dumps({"error": str(exc)}).encode()
                self.send_response(502)
                self.send_header("Content-Type", "application/json")
                self.send_header("Content-Length", str(len(msg)))
                self.end_headers()
                self.wfile.write(msg)

        def do_GET(self):
            if self.path in ("/health", "/livez", "/readyz"):
                body = b'{"status":"ok"}'
                self.send_response(200)
                self.send_header("Content-Type", "application/json")
                self.send_header("Content-Length", str(len(body)))
                self.end_headers()
                self.wfile.write(body)
                return
            self._forward()

        def do_POST(self):   self._forward()
        def do_PUT(self):    self._forward()
        def do_DELETE(self): self._forward()
        def do_PATCH(self):  self._forward()

    server = http.server.HTTPServer(("127.0.0.1", args.port), _Handler)
    print(f"synaxi-proxy listening on http://127.0.0.1:{args.port} -> {upstream}", flush=True)
    server.serve_forever()


if __name__ == "__main__":
    main()
