"""End-to-end thrash regression: drive the REAL proxy subprocess and prove the
world-cache budget stops the re-read loop.

This is the automated version of "recreate the chat and make sure it executes
properly". Instead of a live Claude session (auth, rate limits, non-determinism)
it stands up the whole transport for real —

    client loop  ->  proxy subprocess (projection)  ->  mock upstream

— and reproduces the exact failure from the logs at the loop level.

The mock upstream is a *faithful* stand-in for the model's re-read behaviour: on
each turn it looks at the (already-projected) context it was handed and

  * if it can still SEE the big file it read earlier -> makes progress (a Bash
    step),
  * if the file is GONE from its context -> re-reads it (`Read(bigfile)`),

which is precisely why a real model loops when projection evicts a file it still
needs. The client plays Claude Code: it keeps the full, growing history and
executes each tool call, so the file is always in the *raw* transcript — whether
it survives into the *projected* context is entirely down to the world-cache
budget under test.

Result:
  * budget 80_000 (the fix)  -> the >8 K-token file stays resident -> read ONCE.
  * budget  8_000 (old value)-> the file is evicted every turn -> re-read again
    and again (the thrash), which is what pinned the rate limit in production.

No network, no auth, no Ollama — deterministic and fast.
"""
from __future__ import annotations

import json
import os
import socket
import threading
import time
import urllib.request
from http.server import BaseHTTPRequestHandler, HTTPServer

import pytest

from synaxi_projection.projection import WORKER_SENTINEL
from synaxi_projection.proxy import start_proxy, stop_proxy

# A file whose content is > 8 000 tokens (~32 K chars) so it exceeds the old
# budget on its own, but well under 80 000 so it fits the fixed one. The marker
# is what the mock looks for to decide "can I still see the file?".
BIG_PATH = "/repo/big_doc.md"
BIG_MARKER = "BEGIN-BIG-DOC-UNIQUE-MARKER"
BIG_CONTENT = BIG_MARKER + "\n" + ("lorem ipsum dolor sit amet " * 1500)  # ~40 K chars

TASK = (
    f"Your task: read {BIG_PATH}, then perform several build steps, "
    f"re-consulting the document as needed."
)
MAX_TURNS = 12


def _free_port() -> int:
    s = socket.socket()
    s.bind(("127.0.0.1", 0))
    port = s.getsockname()[1]
    s.close()
    return port


# ---------------------------------------------------------------------------
# Mock upstream: a deterministic agent that re-reads only when it can't see the
# file. Speaks the non-streaming Anthropic Messages JSON the proxy forwards to.
# ---------------------------------------------------------------------------

def _make_upstream(step_counter: dict):
    class MockUpstream(BaseHTTPRequestHandler):
        def log_message(self, *a):  # silence
            pass

        def do_GET(self):  # health probes
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(b'{"status":"ok"}')

        def do_POST(self):
            n = int(self.headers.get("Content-Length", 0))
            raw = self.rfile.read(n) if n else b"{}"
            try:
                payload = json.loads(raw)
            except Exception:
                payload = {}

            # What can the model actually SEE this turn (the projected context)?
            visible = json.dumps(payload.get("messages") or [])
            can_see_file = BIG_MARKER in visible

            step_counter["turns"] += 1
            tid = f"tu{step_counter['turns']}"

            if not can_see_file:
                # The file it needs is not in context -> re-read it. This is the
                # thrash; every occurrence past the first is wasted work.
                block = {"type": "tool_use", "id": tid, "name": "Read",
                         "input": {"file_path": BIG_PATH}}
                stop = "tool_use"
            else:
                # It can see the file -> make progress with a build step.
                step_counter["progress"] += 1
                block = {"type": "tool_use", "id": tid, "name": "Bash",
                         "input": {"command": f"echo step {step_counter['progress']}"}}
                stop = "tool_use"

            msg = {
                "id": f"msg{step_counter['turns']}", "type": "message",
                "role": "assistant", "model": "mock",
                "content": [block], "stop_reason": stop, "stop_sequence": None,
                "usage": {"input_tokens": len(visible) // 4, "output_tokens": 5},
            }
            body = json.dumps(msg).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)

    return MockUpstream


def _serve(server):
    t = threading.Thread(target=server.serve_forever, daemon=True)
    t.start()
    return t


def _client_loop(proxy_port: int) -> dict:
    """Play Claude Code: keep the full growing history, POST it to the proxy
    each turn, execute the returned tool call, and count re-reads of the file."""
    system = [{"type": "text",
               "text": f"{WORKER_SENTINEL}\nYou are an autonomous coding worker."}]
    tools = [{"name": "Read", "input_schema": {"type": "object"}},
             {"name": "Bash", "input_schema": {"type": "object"}}]
    messages = [{"role": "user", "content": [{"type": "text", "text": TASK}]}]

    reads = 0
    for _ in range(MAX_TURNS):
        req = urllib.request.Request(
            f"http://127.0.0.1:{proxy_port}/v1/messages",
            data=json.dumps({"model": "claude-x", "max_tokens": 1024,
                             "stream": False, "system": system,
                             "tools": tools, "messages": messages}).encode(),
            headers={"Content-Type": "application/json"}, method="POST")
        with urllib.request.urlopen(req, timeout=30) as r:
            resp = json.loads(r.read())

        content = resp.get("content") or []
        tool_use = next((b for b in content if b.get("type") == "tool_use"), None)
        if tool_use is None:
            break

        # Append the assistant turn verbatim (as Claude Code would)...
        messages.append({"role": "assistant", "content": content})
        # ...then execute the tool and append its result to the FULL history.
        if tool_use["name"] == "Read" and tool_use["input"].get("file_path") == BIG_PATH:
            reads += 1
            result = BIG_CONTENT
        else:
            result = "ok"
        messages.append({"role": "user", "content": [
            {"type": "tool_result", "tool_use_id": tool_use["id"], "content": result}]})

    return {"reads": reads, "turns": MAX_TURNS}


@pytest.mark.parametrize("budget,expect_reads", [
    (80_000, 1),   # the fix: file stays resident -> read exactly once
    (8_000, None), # old value: file evicted every turn -> thrash (many re-reads)
])
def test_world_budget_stops_thrash_end_to_end(tmp_path, budget, expect_reads):
    upstream_port = _free_port()
    step_counter = {"turns": 0, "progress": 0}
    upstream = HTTPServer(("127.0.0.1", upstream_port), _make_upstream(step_counter))
    _serve(upstream)

    proxy_port = _free_port()
    prev_budget = os.environ.get("SYNAXI_WORLD_TOKEN_BUDGET")
    prev_logdir = os.environ.get("SYNAXI_LOG_DIR")
    os.environ["SYNAXI_WORLD_TOKEN_BUDGET"] = str(budget)
    os.environ["SYNAXI_LOG_DIR"] = str(tmp_path / "logs")
    proc = None
    try:
        proc = start_proxy(port=proxy_port,
                           upstream=f"http://127.0.0.1:{upstream_port}",
                           model="mock-model")
        out = _client_loop(proxy_port)

        if expect_reads is not None:
            # The fix: the big file is read once and then always replayed into
            # the projected context, so the model never needs to re-read it.
            assert out["reads"] == expect_reads, (
                f"budget={budget}: expected {expect_reads} read(s), got "
                f"{out['reads']} — the working set should stay resident")
        else:
            # The old budget thrashes: the file is evicted and re-read many
            # times. Pinning this proves the test genuinely reproduces the bug
            # (and that the fix above is what removes it).
            assert out["reads"] >= 3, (
                f"budget={budget}: expected the old budget to thrash (>=3 "
                f"re-reads), got {out['reads']} — the reproduction is invalid")
    finally:
        stop_proxy(proc)
        upstream.shutdown()
        if prev_budget is None:
            os.environ.pop("SYNAXI_WORLD_TOKEN_BUDGET", None)
        else:
            os.environ["SYNAXI_WORLD_TOKEN_BUDGET"] = prev_budget
        if prev_logdir is None:
            os.environ.pop("SYNAXI_LOG_DIR", None)
        else:
            os.environ["SYNAXI_LOG_DIR"] = prev_logdir
