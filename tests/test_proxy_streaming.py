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


def _post(port, stream):
    req = urllib.request.Request(
        f"http://127.0.0.1:{port}/v1/messages",
        data=json.dumps({"model": "claude-x", "stream": stream,
                         "messages": [{"role": "user", "content": "hey"}]}).encode(),
        headers={"Content-Type": "application/json"}, method="POST")
    with urllib.request.urlopen(req, timeout=10) as r:
        return r.headers.get("Content-Type"), r.read().decode()


def test_end_to_end_stream_vs_json(tmp_path):
    upstream = HTTPServer(("127.0.0.1", 0), _MockUpstream)
    up_port = upstream.server_address[1]
    _serve(upstream)

    mod = _load_proxy(f"http://127.0.0.1:{up_port}", str(tmp_path / "logs"))
    proxy = HTTPServer(("127.0.0.1", 0), mod.ProxyHandler)
    px_port = proxy.server_address[1]
    _serve(proxy)
    try:
        # readiness
        deadline = time.time() + 5
        while time.time() < deadline:
            try:
                urllib.request.urlopen(f"http://127.0.0.1:{px_port}/health", timeout=1)
                break
            except Exception:
                time.sleep(0.05)

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
