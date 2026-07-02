"""
synaxi_projection._proxy_server
MITM proxy between Claude Code and Ollama (or Anthropic).

Ollama speaks the Anthropic Messages API natively (v0.14.0+), so no format
translation is needed. This proxy's whole job is projection: on every
/v1/messages request it replaces Claude Code's enormous accumulated context
with a compact, correctly-paired one rebuilt by
synaxi_projection.projection.project_payload. It then:

  1. Rewrites the model name (claude-* -> the local Ollama tag)
  2. Forces non-streaming so the full response can be buffered + logged
  3. Injects x-api-key: ollama when the upstream is Ollama
  4. Forwards everything else verbatim and records request/response to JSONL

The actual projection logic lives in projection.py (shared with the in-process
benchmark loop) - this file is only transport + logging.

Configured via env vars:
    SYNAXI_UPSTREAM   e.g. http://127.0.0.1:11434   (default: https://api.anthropic.com)
    SYNAXI_PORT       listen port                    (default: 8787)
    SYNAXI_MODEL      force model name               (default: qwen2.5-coder:7b for Ollama)
    SYNAXI_LOG_DIR    conversation log dir           (default: ~/.synaxi-projection/conversations)
"""
import http.server
import json
import os
import ssl
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path

# Import the canonical projection engine. This module is launched as a
# standalone script (so sys.path[0] is this directory, not the repo root);
# fall back to inserting the repo root so the package import resolves.
try:
    from synaxi_projection.projection import project_payload
except ImportError:  # pragma: no cover - script-mode bootstrap
    sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    from synaxi_projection.projection import project_payload

UPSTREAM = os.environ.get("SYNAXI_UPSTREAM", "https://api.anthropic.com").rstrip("/")
PORT = int(os.environ.get("SYNAXI_PORT", "8787"))
MODEL = os.environ.get("SYNAXI_MODEL", "")
IS_OLLAMA = "api.anthropic.com" not in UPSTREAM
DISABLE_PROJECTION = os.environ.get("SYNAXI_DISABLE_PROJECTION", "").strip().lower() not in ("", "0", "false", "no")

LOG_DIR = Path(os.environ.get("SYNAXI_LOG_DIR", Path.home() / ".synaxi-projection" / "conversations"))
LOG_DIR.mkdir(parents=True, exist_ok=True)
LOG_FILE = LOG_DIR / f"session_{int(time.time())}.jsonl"


def _log(entry):
    try:
        with LOG_FILE.open("a") as f:
            f.write(json.dumps(entry) + "\n")
    except Exception:
        pass


def _is_messages_path(path):
    """True for /v1/messages, tolerating trailing slash and ?beta=true etc."""
    return path.split("?")[0].rstrip("/").endswith("/v1/messages")


class ProxyHandler(http.server.BaseHTTPRequestHandler):
    def log_message(self, fmt, *args):
        print(f"[proxy] {self.command} {self.path}", flush=True)

    def do_GET(self):
        if self.path in ("/health", "/livez", "/readyz"):
            body = b'{"status":"ok"}'
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
            return
        self._forward(b"")

    def do_HEAD(self):
        # Claude Code sends HEAD / to probe the endpoint before making API calls.
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.end_headers()

    def do_POST(self):
        length = int(self.headers.get("Content-Length", 0))
        body = self.rfile.read(length) if length else b""

        if _is_messages_path(self.path):
            try:
                payload = json.loads(body) if body else {}
            except Exception:
                payload = {}

            original_msg_count = len(payload.get("messages") or [])
            original_system_len = len(str(payload.get("system") or ""))
            original_tools_count = len(payload.get("tools") or [])

            # 1. Apply projection (rebuild compact, correctly-paired context).
            # Baseline A/B (SYNAXI_DISABLE_PROJECTION=1): forward the
            # full, growing payload untouched so projection can be
            # compared against no-projection on the same model.
            if not DISABLE_PROJECTION:
                payload = project_payload(payload, preserve_claude_identity=not IS_OLLAMA)

            # 2. Rewrite the model name when talking to Ollama.
            if IS_OLLAMA:
                payload["model"] = MODEL or "qwen2.5-coder:7b"

            # 3. Force non-streaming so the full response can be buffered + logged.
            payload["stream"] = False

            body = json.dumps(payload).encode()

            # 4. Forward upstream and capture the response for logging.
            resp_body = self._forward_capture(body)

            try:
                resp_json = json.loads(resp_body) if resp_body else {}
            except Exception:
                resp_json = {}

            projected_msgs = payload.get("messages") or []
            first_user = projected_msgs[0].get("content", "") if projected_msgs else ""
            if isinstance(first_user, list):
                first_user = " ".join(b.get("text", "") for b in first_user if isinstance(b, dict))
            _log({
                "ts": time.time(),
                "original_msg_count": original_msg_count,
                "projected_msg_count": len(projected_msgs),
                "projection_meta": {
                    "original_system_len": original_system_len,
                    "original_tools_count": original_tools_count,
                    "projected_system_len": len(str(payload.get("system") or "")),
                    "projected_tools_count": len(payload.get("tools") or []),
                    "projected_first_user_len": len(str(first_user)),
                },
                "model": payload.get("model"),
                "request": payload,
                "response": resp_json,
            })

            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(resp_body)))
            self.end_headers()
            self.wfile.write(resp_body)
            return

        self._forward(body)

    def do_PUT(self):
        length = int(self.headers.get("Content-Length", 0))
        self._forward(self.rfile.read(length) if length else b"")

    def do_DELETE(self):
        self._forward(b"")

    def do_PATCH(self):
        length = int(self.headers.get("Content-Length", 0))
        self._forward(self.rfile.read(length) if length else b"")

    def _build_opener(self, url):
        if url.startswith("https://"):
            ctx = ssl.create_default_context()
            return urllib.request.build_opener(
                urllib.request.ProxyHandler({}),
                urllib.request.HTTPSHandler(context=ctx),
            )
        return urllib.request.build_opener(urllib.request.ProxyHandler({}))

    def _upstream_headers(self, body_len):
        headers = {
            k: v for k, v in self.headers.items()
            if k.lower() not in ("host", "transfer-encoding", "connection",
                                 "content-length", "accept-encoding")
        }
        if IS_OLLAMA:
            headers["x-api-key"] = "ollama"
        if body_len:
            headers["Content-Length"] = str(body_len)
        return headers

    def _forward_capture(self, body):
        """Forward body upstream and return the response bytes (for logging)."""
        url = UPSTREAM + self.path
        headers = self._upstream_headers(len(body))
        req = urllib.request.Request(url, data=body, headers=headers, method=self.command)
        try:
            with self._build_opener(url).open(req, timeout=600) as resp:
                return resp.read()
        except urllib.error.HTTPError as e:
            return e.read()
        except Exception as exc:
            return json.dumps({"type": "error", "error": {"message": str(exc)}}).encode()

    def _forward(self, body):
        url = UPSTREAM + self.path
        headers = self._upstream_headers(len(body) if body else 0)
        req = urllib.request.Request(url, data=body or None, headers=headers, method=self.command)
        try:
            with self._build_opener(url).open(req, timeout=600) as resp:
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
            msg = json.dumps({"type": "error", "error": {"type": "api_error", "message": str(exc)}}).encode()
            self.send_response(502)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(msg)))
            self.end_headers()
            self.wfile.write(msg)


if __name__ == "__main__":
    server = http.server.HTTPServer(("127.0.0.1", PORT), ProxyHandler)
    print(f"synaxi-proxy on http://127.0.0.1:{PORT} -> {UPSTREAM}", flush=True)
    server.serve_forever()
