"""Proxy streaming (SSE) reconstruction.

The interactive Claude Code TUI sends ``stream: true`` and reads the reply as a
Server-Sent Events stream. The proxy forces non-streaming *upstream* so it can
buffer and log the full response, then re-emits it as SSE for streaming clients.
Without that, the TUI reports "API returned an empty or malformed response
(HTTP 200)". These tests pin both the SSE frame shape and the end-to-end
content-type behaviour (streaming vs. the ``claude -p`` / benchmark JSON path).
"""
from __future__ import annotations

import importlib.util
import json
import os
import threading
import time
import urllib.error
import urllib.request
from http.server import BaseHTTPRequestHandler, HTTPServer
from pathlib import Path

import pytest

PROXY_PATH = Path(__file__).resolve().parent.parent / "synaxi_projection" / "_proxy_server.py"


def _load_proxy(upstream: str, log_dir: str):
    """Load a fresh _proxy_server module bound to the given upstream.

    The module reads UPSTREAM/PORT/MODEL from the environment at import time, so
    we set them first and load via a unique spec name to bypass the import cache.
    """
    os.environ["SYNAXI_UPSTREAM"] = upstream
    os.environ["SYNAXI_MODEL"] = "test-model"
    os.environ["SYNAXI_LOG_DIR"] = log_dir
    spec = importlib.util.spec_from_file_location(f"_proxy_{time.time_ns()}", PROXY_PATH)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


@pytest.fixture(scope="module")
def proxymod(tmp_path_factory):
    return _load_proxy("http://127.0.0.1:1", str(tmp_path_factory.mktemp("logs")))


# ---------------------------------------------------------------------------
# _message_to_sse — frame shape
# ---------------------------------------------------------------------------

def _events(sse_bytes: bytes) -> list[str]:
    return [ln[len("event: "):] for ln in sse_bytes.decode().splitlines()
            if ln.startswith("event: ")]


def _frames(sse_bytes: bytes) -> list[tuple[str, dict]]:
    """Parse an SSE blob into ordered (event, data-dict) pairs."""
    frames, event = [], None
    for ln in sse_bytes.decode().splitlines():
        if ln.startswith("event: "):
            event = ln[len("event: "):]
        elif ln.startswith("data: "):
            frames.append((event, json.loads(ln[len("data: "):])))
    return frames


def test_text_message_frame_sequence(proxymod):
    sse = proxymod._message_to_sse({
        "id": "m", "type": "message", "role": "assistant", "model": "x",
        "content": [{"type": "text", "text": "hello"}],
        "stop_reason": "end_turn", "usage": {"input_tokens": 5, "output_tokens": 2},
    })
    assert _events(sse) == [
        "message_start", "content_block_start", "content_block_delta",
        "content_block_stop", "message_delta", "message_stop",
    ]
    assert "hello" in sse.decode()


def test_tool_use_uses_input_json_delta(proxymod):
    sse = proxymod._message_to_sse({
        "type": "message", "role": "assistant",
        "content": [{"type": "tool_use", "id": "t1", "name": "Bash",
                     "input": {"command": "ls -F"}}],
        "stop_reason": "tool_use", "usage": {"input_tokens": 5, "output_tokens": 9},
    })
    deltas = [d for e, d in _frames(sse) if e == "content_block_delta"]
    assert len(deltas) == 1
    delta = deltas[0]["delta"]
    assert delta["type"] == "input_json_delta"
    # the full tool input round-trips through the single partial_json delta
    assert json.loads(delta["partial_json"]) == {"command": "ls -F"}
    msg_delta = [d for e, d in _frames(sse) if e == "message_delta"][0]
    assert msg_delta["delta"]["stop_reason"] == "tool_use"


def test_error_object_becomes_sse_error_event(proxymod):
    sse = proxymod._message_to_sse(
        {"type": "error", "error": {"type": "overloaded_error", "message": "busy"}})
    assert _events(sse) == ["error"]
    assert "overloaded_error" in sse.decode()


def test_thinking_block_replays_signature_via_delta(proxymod):
    """Regression: adaptive thinking returns empty thinking text + a signature.

    Claude Code rebuilds thinking blocks from deltas, not from the inline
    content_block_start, so the signature MUST be replayed as a signature_delta.
    Otherwise the client reconstructs {"thinking":"","signature":""}, echoes it
    back next turn, and Anthropic rejects it with "each thinking block must
    contain thinking" (surfaced as an empty/HTTP-200 error).
    """
    sse = proxymod._message_to_sse({
        "type": "message", "role": "assistant",
        "content": [
            {"type": "thinking", "thinking": "", "signature": "SIG-4720-CHARS"},
            {"type": "tool_use", "id": "t1", "name": "Bash",
             "input": {"command": "ls"}},
        ],
        "stop_reason": "tool_use", "usage": {"input_tokens": 5, "output_tokens": 9},
    })
    frames = _frames(sse)
    # The thinking block starts empty and its signature arrives via a delta.
    starts = [d for e, d in frames if e == "content_block_start"]
    think_start = next(d for d in starts if d["content_block"].get("type") == "thinking")
    assert think_start["content_block"] == {"type": "thinking", "thinking": ""}
    sig_deltas = [d for e, d in frames
                  if e == "content_block_delta"
                  and d["delta"].get("type") == "signature_delta"]
    assert len(sig_deltas) == 1
    assert sig_deltas[0]["delta"]["signature"] == "SIG-4720-CHARS"


def test_thinking_with_text_replays_both_deltas(proxymod):
    sse = proxymod._message_to_sse({
        "type": "message", "role": "assistant",
        "content": [{"type": "thinking", "thinking": "let me reason",
                     "signature": "SIG"}],
        "stop_reason": "end_turn", "usage": {"input_tokens": 1, "output_tokens": 1},
    })
    kinds = [d["delta"]["type"] for e, d in _frames(sse) if e == "content_block_delta"]
    assert kinds == ["thinking_delta", "signature_delta"]
    assert "let me reason" in sse.decode()


def test_redacted_thinking_passes_through_whole(proxymod):
    """redacted_thinking carries its payload in ``data`` (no deltas), so it must
    be delivered whole in the start frame."""
    sse = proxymod._message_to_sse({
        "type": "message", "role": "assistant",
        "content": [{"type": "redacted_thinking", "data": "ENCRYPTED-BLOB"}],
        "stop_reason": "end_turn", "usage": {"input_tokens": 1, "output_tokens": 1},
    })
    starts = [d for e, d in _frames(sse) if e == "content_block_start"]
    rt = next(d for d in starts if d["content_block"].get("type") == "redacted_thinking")
    assert rt["content_block"]["data"] == "ENCRYPTED-BLOB"


def test_empty_response_is_graceful(proxymod):
    # An unparseable/empty upstream body must still yield a valid, non-blank
    # frame set the client can parse — never a bare body it would call "malformed".
    events = _events(proxymod._message_to_sse({}))
    assert events  # non-empty
    assert events[0] in ("message_start", "error")
    assert events[-1] in ("message_stop", "error")


# ---------------------------------------------------------------------------
# End-to-end: streaming client gets SSE, non-streaming client gets JSON
# ---------------------------------------------------------------------------

_CANNED = {
    "id": "msg_up", "type": "message", "role": "assistant", "model": "claude-x",
    "content": [{"type": "text", "text": "hi from upstream"}],
    "stop_reason": "end_turn", "usage": {"input_tokens": 10, "output_tokens": 4},
}


class _MockUpstream(BaseHTTPRequestHandler):
    def log_message(self, *a):  # silence
        pass

    def do_POST(self):
        n = int(self.headers.get("Content-Length", 0))
        if n:
            self.rfile.read(n)
        body = json.dumps(_CANNED).encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


def _serve(server):
    t = threading.Thread(target=server.serve_forever, daemon=True)
    t.start()
    return t


def _wait_ready(port, timeout=5):
    deadline = time.time() + timeout
    while time.time() < deadline:
        try:
            urllib.request.urlopen(f"http://127.0.0.1:{port}/health", timeout=1)
            return
        except Exception:
            time.sleep(0.05)


def _post(port, stream):
    req = urllib.request.Request(
        f"http://127.0.0.1:{port}/v1/messages",
        data=json.dumps({"model": "claude-x", "stream": stream,
                         "messages": [{"role": "user", "content": "hey"}]}).encode(),
        headers={"Content-Type": "application/json"}, method="POST")
    with urllib.request.urlopen(req, timeout=10) as r:
        return r.headers.get("Content-Type"), r.read().decode()


def _post_capture(port, stream):
    """POST and return ``(status, headers, body)`` even for non-2xx responses."""
    req = urllib.request.Request(
        f"http://127.0.0.1:{port}/v1/messages",
        data=json.dumps({"model": "claude-x", "stream": stream,
                         "messages": [{"role": "user", "content": "hey"}]}).encode(),
        headers={"Content-Type": "application/json"}, method="POST")
    try:
        with urllib.request.urlopen(req, timeout=10) as r:
            return r.status, dict(r.headers), r.read().decode()
    except urllib.error.HTTPError as e:
        return e.code, dict(e.headers), e.read().decode()


def test_end_to_end_stream_vs_json(tmp_path):
    upstream = HTTPServer(("127.0.0.1", 0), _MockUpstream)
    up_port = upstream.server_address[1]
    _serve(upstream)

    mod = _load_proxy(f"http://127.0.0.1:{up_port}", str(tmp_path / "logs"))
    proxy = HTTPServer(("127.0.0.1", 0), mod.ProxyHandler)
    px_port = proxy.server_address[1]
    _serve(proxy)
    try:
        _wait_ready(px_port)

        ct_s, body_s = _post(px_port, True)
        assert ct_s.startswith("text/event-stream")
        assert "event: message_start" in body_s
        assert "event: message_stop" in body_s
        assert "hi from upstream" in body_s

        ct_j, body_j = _post(px_port, False)
        assert ct_j.startswith("application/json")
        assert json.loads(body_j)["content"][0]["text"] == "hi from upstream"
    finally:
        proxy.shutdown()
        upstream.shutdown()


# ---------------------------------------------------------------------------
# Upstream errors reach the client with their real status (not a flattened 200)
# ---------------------------------------------------------------------------
# Regression: a worker hit Anthropic's rate limit after ~400 projected turns.
# Upstream returned HTTP 429, but the proxy forced HTTP 200 around the error
# envelope, so Claude Code reported "empty or malformed response (HTTP 200) —
# check for a proxy or gateway intercepting the request" and killed the agent
# instead of backing off. The proxy must relay the real status + Retry-After.

class _RateLimitUpstream(BaseHTTPRequestHandler):
    def log_message(self, *a):  # silence
        pass

    def do_POST(self):
        n = int(self.headers.get("Content-Length", 0))
        if n:
            self.rfile.read(n)
        body = json.dumps({
            "type": "error",
            "error": {"type": "rate_limit_error",
                      "message": "This request would exceed your account's rate limit."},
        }).encode()
        self.send_response(429)
        self.send_header("Content-Type", "application/json")
        self.send_header("Retry-After", "42")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


class _BlankUpstream(BaseHTTPRequestHandler):
    def log_message(self, *a):  # silence
        pass

    def do_POST(self):
        n = int(self.headers.get("Content-Length", 0))
        if n:
            self.rfile.read(n)
        # HTTP 200 with an empty body — the other shape of the "malformed 200".
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", "0")
        self.end_headers()


@pytest.mark.parametrize("stream", [True, False])
def test_upstream_rate_limit_status_is_propagated(tmp_path, stream):
    upstream = HTTPServer(("127.0.0.1", 0), _RateLimitUpstream)
    up_port = upstream.server_address[1]
    _serve(upstream)
    mod = _load_proxy(f"http://127.0.0.1:{up_port}", str(tmp_path / "logs"))
    proxy = HTTPServer(("127.0.0.1", 0), mod.ProxyHandler)
    px_port = proxy.server_address[1]
    _serve(proxy)
    try:
        _wait_ready(px_port)
        status, headers, body = _post_capture(px_port, stream)
        # The real 429 must reach the client (NEVER flattened to 200, NEVER
        # re-emitted as an SSE 200), so Claude Code's native backoff engages.
        assert status == 429
        assert json.loads(body)["error"]["type"] == "rate_limit_error"
        # Retry-After is preserved so the client waits the right amount.
        assert headers.get("Retry-After") == "42"
    finally:
        proxy.shutdown()
        upstream.shutdown()


def test_blank_200_upstream_becomes_502(tmp_path):
    upstream = HTTPServer(("127.0.0.1", 0), _BlankUpstream)
    up_port = upstream.server_address[1]
    _serve(upstream)
    mod = _load_proxy(f"http://127.0.0.1:{up_port}", str(tmp_path / "logs"))
    proxy = HTTPServer(("127.0.0.1", 0), mod.ProxyHandler)
    px_port = proxy.server_address[1]
    _serve(proxy)
    try:
        _wait_ready(px_port)
        status, _headers, body = _post_capture(px_port, True)
        # An empty/malformed 200 is the exact trap that makes Claude Code report
        # "malformed response (HTTP 200)". Promote it to a real 502 error.
        assert status == 502
        assert json.loads(body)["error"]["type"] == "api_error"
    finally:
        proxy.shutdown()
        upstream.shutdown()

