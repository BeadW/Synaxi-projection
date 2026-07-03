"""
synaxi_projection._proxy_server
MITM proxy between Claude Code and Ollama (or Anthropic).

Ollama speaks the Anthropic Messages API natively (v0.14.0+), so no format
translation is needed. This proxy's whole job is projection: on each
/v1/messages request from the Synaxi *worker* subagent it replaces Claude
Code's enormous accumulated context with a compact, correctly-paired one
rebuilt by synaxi_projection.projection.project_payload. Requests that are not
the worker (interactive chat, /init, the tool-free chat orchestrator, and
title / topic / quota sidecars) are forwarded untouched. It then:

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
    from synaxi_projection.projection import project_payload, is_worker_payload
except ImportError:  # pragma: no cover - script-mode bootstrap
    sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    from synaxi_projection.projection import project_payload, is_worker_payload

UPSTREAM = os.environ.get("SYNAXI_UPSTREAM", "https://api.anthropic.com").rstrip("/")
PORT = int(os.environ.get("SYNAXI_PORT", "8787"))
MODEL = os.environ.get("SYNAXI_MODEL", "")
IS_OLLAMA = "api.anthropic.com" not in UPSTREAM
DISABLE_PROJECTION = os.environ.get("SYNAXI_DISABLE_PROJECTION", "").strip().lower() not in ("", "0", "false", "no")
# By default projection is applied ONLY to the Synaxi worker subagent (detected
# by the sentinel its system prompt carries). Set SYNAXI_PROJECT_ALL=1 to
# project every /v1/messages request instead — the pre-subagent behaviour, kept
# for benchmarking / A-B against a small local model with no custom agent.
PROJECT_ALL = os.environ.get("SYNAXI_PROJECT_ALL", "").strip().lower() not in ("", "0", "false", "no")

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


def _sse_event(event_type, data_obj):
    """Encode one Anthropic-style Server-Sent Event frame."""
    return f"event: {event_type}\ndata: {json.dumps(data_obj)}\n\n".encode()


def _message_to_sse(msg):
    """Reconstruct an Anthropic Messages SSE stream from a buffered response.

    Claude Code's interactive TUI sends ``stream: true`` and parses the reply as
    Server-Sent Events. We force non-streaming *upstream* (so the full response
    can be buffered and logged), then re-emit that single response as the SSE
    event sequence the client expects:

        message_start
        (content_block_start / content_block_delta / content_block_stop) * N
        message_delta
        message_stop

    Only text and tool_use blocks are reconstructed precisely (they cover
    coding-agent responses); any other block type is passed through in its
    ``content_block_start`` frame. An upstream error object is surfaced as an
    SSE ``error`` event so the client shows the real message instead of a
    generic "malformed response".
    """
    if not isinstance(msg, dict) or msg.get("type") == "error":
        err = msg if isinstance(msg, dict) else {
            "type": "error",
            "error": {"type": "api_error", "message": "empty upstream response"},
        }
        return _sse_event("error", err)

    content = msg.get("content") or []
    usage = msg.get("usage") or {}

    out = bytearray()
    out += _sse_event("message_start", {
        "type": "message_start",
        "message": {
            "id": msg.get("id", "msg_proxy"),
            "type": "message",
            "role": msg.get("role", "assistant"),
            "model": msg.get("model", ""),
            "content": [],
            "stop_reason": None,
            "stop_sequence": None,
            "usage": {"input_tokens": usage.get("input_tokens", 0),
                      "output_tokens": 0},
        },
    })

    for i, block in enumerate(content):
        if not isinstance(block, dict):
            continue
        btype = block.get("type")
        if btype == "text":
            out += _sse_event("content_block_start", {
                "type": "content_block_start", "index": i,
                "content_block": {"type": "text", "text": ""}})
            out += _sse_event("content_block_delta", {
                "type": "content_block_delta", "index": i,
                "delta": {"type": "text_delta", "text": block.get("text", "")}})
            out += _sse_event("content_block_stop", {
                "type": "content_block_stop", "index": i})
        elif btype == "tool_use":
            out += _sse_event("content_block_start", {
                "type": "content_block_start", "index": i,
                "content_block": {"type": "tool_use", "id": block.get("id", ""),
                                  "name": block.get("name", ""), "input": {}}})
            out += _sse_event("content_block_delta", {
                "type": "content_block_delta", "index": i,
                "delta": {"type": "input_json_delta",
                          "partial_json": json.dumps(block.get("input", {}))}})
            out += _sse_event("content_block_stop", {
                "type": "content_block_stop", "index": i})
        elif btype == "thinking":
            # Extended-thinking block. Claude Code builds the block from an
            # empty start frame plus DELTAS, ignoring any thinking/signature
            # placed inline in content_block_start. With adaptive thinking the
            # model often returns empty thinking text but a long ``signature``
            # (Anthropic verifies the block by that signature on the next turn).
            # If we don't replay the signature via a ``signature_delta`` the
            # client reconstructs {"thinking":"","signature":""}, echoes that
            # back next turn, and Anthropic rejects it with "each thinking block
            # must contain thinking" — surfaced to the user as an empty/HTTP-200
            # error. So stream it the way the client expects.
            out += _sse_event("content_block_start", {
                "type": "content_block_start", "index": i,
                "content_block": {"type": "thinking", "thinking": ""}})
            thinking_text = block.get("thinking") or ""
            if thinking_text:
                out += _sse_event("content_block_delta", {
                    "type": "content_block_delta", "index": i,
                    "delta": {"type": "thinking_delta", "thinking": thinking_text}})
            signature = block.get("signature") or ""
            if signature:
                out += _sse_event("content_block_delta", {
                    "type": "content_block_delta", "index": i,
                    "delta": {"type": "signature_delta", "signature": signature}})
            out += _sse_event("content_block_stop", {
                "type": "content_block_stop", "index": i})
        else:
            # redacted_thinking / unknown: opaque to us (a redacted_thinking
            # block carries its payload in ``data``, not deltas), so pass the
            # whole block through in the start frame — the client stores it
            # verbatim and can return it unchanged.
            out += _sse_event("content_block_start", {
                "type": "content_block_start", "index": i,
                "content_block": block})
            out += _sse_event("content_block_stop", {
                "type": "content_block_stop", "index": i})

    out += _sse_event("message_delta", {
        "type": "message_delta",
        "delta": {"stop_reason": msg.get("stop_reason"),
                  "stop_sequence": msg.get("stop_sequence")},
        "usage": {"output_tokens": usage.get("output_tokens", 0)},
    })
    out += _sse_event("message_stop", {"type": "message_stop"})
    return bytes(out)


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
            # Whether the CLIENT asked for a streaming (SSE) response. We always
            # force non-streaming upstream (below) to buffer + log the full
            # reply, then re-emit it as SSE if the client wanted a stream.
            client_wants_stream = bool(payload.get("stream"))

            # 1. Apply projection (rebuild compact, correctly-paired context).
            # Gate: project ONLY the Synaxi worker subagent's turns, detected by
            # the sentinel its system prompt carries (see projection.py). The
            # interactive chat orchestrator, /init, and lightweight sidecars
            # (title / topic / quota) carry no sentinel and pass through
            # untouched — which is also what keeps conversational turns intact.
            #   * SYNAXI_DISABLE_PROJECTION=1 -> forward everything untouched
            #     (baseline A/B: projection vs no-projection on the same model).
            #   * SYNAXI_PROJECT_ALL=1        -> project every request
            #     (pre-subagent behaviour, for benchmarking a small local model).
            is_worker = is_worker_payload(payload)
            do_project = (not DISABLE_PROJECTION) and (PROJECT_ALL or is_worker)
            if do_project:
                payload = project_payload(payload, preserve_claude_identity=not IS_OLLAMA)

            # 2. Rewrite the model name when talking to Ollama.
            if IS_OLLAMA:
                payload["model"] = MODEL or "qwen2.5-coder:7b"

            # 3. Force non-streaming so the full response can be buffered + logged.
            payload["stream"] = False

            body = json.dumps(payload).encode()

            # 4. Forward upstream and capture the response (status + body).
            status, up_headers, resp_body = self._forward_capture(body)

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
                    "is_worker": is_worker,
                    "projected": do_project,
                    "upstream_status": status,
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

            # Surface upstream failures with their REAL status code. Anthropic
            # signals rate limits (429), overload (529), and server faults (5xx)
            # via HTTP status, and Claude Code backs off / retries on those. If we
            # flatten them to 200 — whether as an error envelope or an empty body
            # — the client can't parse a Message and reports "empty or malformed
            # response (HTTP 200)", terminating the agent instead of retrying. A
            # 200 with an unparseable/empty body is the same trap, so promote it
            # to 502. Errors are relayed verbatim (never re-emitted as SSE); only
            # a genuine 2xx Message flows to the stream/JSON path below.
            is_error_body = isinstance(resp_json, dict) and resp_json.get("type") == "error"
            is_blank_200 = status < 400 and (not resp_json or "content" not in resp_json)
            if status >= 400 or is_error_body or is_blank_200:
                if status < 400:
                    # A 2xx wrapping an error envelope, or an empty/malformed 2xx:
                    # promote to 502 so the client treats it as a real failure.
                    status = 502
                    if is_blank_200 and not is_error_body:
                        resp_body = json.dumps({
                            "type": "error",
                            "error": {"type": "api_error",
                                      "message": "upstream returned an empty or malformed "
                                                 "response with HTTP 200"},
                        }).encode()
                self.send_response(status)
                self.send_header("Content-Type", "application/json")
                # Preserve retry-after so the client backs off the right amount.
                if up_headers is not None:
                    retry_after = up_headers.get("retry-after")
                    if retry_after:
                        self.send_header("Retry-After", retry_after)
                self.send_header("Content-Length", str(len(resp_body)))
                self.end_headers()
                self.wfile.write(resp_body)
                return

            # Re-emit a genuine success as SSE when the client requested a stream
            # (interactive Claude Code TUI); otherwise return the buffered JSON
            # (claude -p, benchmark harness).
            if client_wants_stream:
                out_body = _message_to_sse(resp_json)
                self.send_response(200)
                self.send_header("Content-Type", "text/event-stream; charset=utf-8")
                self.send_header("Cache-Control", "no-cache")
                self.send_header("Content-Length", str(len(out_body)))
                self.end_headers()
                self.wfile.write(out_body)
                return

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
        """Forward body upstream and return ``(status, headers, body-bytes)``.

        The status and headers are propagated by the ``/v1/messages`` handler so
        that upstream failures (429 rate-limit, 529 overload, 5xx, 404) reach
        Claude Code with their REAL HTTP status instead of being flattened to
        200. Claude Code has native backoff/retry for those statuses; if we hand
        it a 200 wrapping an error envelope (or an empty body) it can't parse a
        Message and reports "empty or malformed response (HTTP 200)", killing the
        agent instead of retrying.
        """
        url = UPSTREAM + self.path
        headers = self._upstream_headers(len(body))
        req = urllib.request.Request(url, data=body, headers=headers, method=self.command)
        try:
            with self._build_opener(url).open(req, timeout=600) as resp:
                return resp.status, resp.headers, resp.read()
        except urllib.error.HTTPError as e:
            return e.code, e.headers, e.read()
        except Exception as exc:
            body = json.dumps({"type": "error",
                               "error": {"type": "api_error", "message": str(exc)}}).encode()
            return 502, None, body


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
