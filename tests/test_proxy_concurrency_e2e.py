"""End-to-end concurrency regression: prove the proxy serves simultaneous
requests in parallel (the subagent scenario) instead of serialising them.

Why this test exists
--------------------
``synaxi-chat`` orchestrates a subagent, and that makes projection concurrent. A
single ``Agent(synaxi-worker)`` turn puts several requests in flight at the proxy
at once — the worker's own ``/v1/messages`` calls plus Claude Code's parallel
title / topic / quota sidecars — while the parent may still be polling.

The original proxy used a single-threaded ``http.server.HTTPServer``, which
serves ONE connection at a time and blocks the whole process inside the upstream
call (``timeout=600`` in ``_forward_capture``). So the instant a subagent
spawned, the second connection could not be accepted and Claude Code reported
"Unable to connect to API (ConnectionRefused)", interrupting the worker.

The fix makes the server thread-per-connection (``_ThreadingProxyServer``). This
test stands up the REAL proxy subprocess in front of a deliberately SLOW mock
upstream and fires N concurrent requests. The mock counts how many requests are
inside its handler at once:

  * threaded proxy (the fix)  -> requests overlap        -> max inflight >= 2
  * single-threaded (the bug) -> requests are serialised -> max inflight == 1

No network, no auth — deterministic and fast.
"""
from __future__ import annotations

import json
import os
import socket
import threading
import time
import urllib.request
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

from synaxi_projection.proxy import start_proxy, stop_proxy

N_CONCURRENT = 3
UPSTREAM_DELAY = 0.8  # seconds the mock holds each request open

# Bypass any ambient HTTP(S)_PROXY in the environment (the dev box may be running
# other MITM proxies) so the client talks straight to our proxy under test.
_OPENER = urllib.request.build_opener(urllib.request.ProxyHandler({}))


def _free_port() -> int:
    s = socket.socket()
    s.bind(("127.0.0.1", 0))
    port = s.getsockname()[1]
    s.close()
    return port


# ---------------------------------------------------------------------------
# Slow mock upstream: holds each request open for UPSTREAM_DELAY and records the
# peak number of requests being handled simultaneously.
# ---------------------------------------------------------------------------

def _make_slow_upstream(state, lock):
    class SlowUpstream(BaseHTTPRequestHandler):
        def log_message(self, *a):  # silence
            pass

        def do_GET(self):  # health probe issued by start_proxy
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(b'{"status":"ok"}')

        def do_POST(self):
            n = int(self.headers.get("Content-Length", 0))
            if n:
                self.rfile.read(n)
            # Peak concurrency = how many POSTs are inside this handler at once.
            # A single-threaded proxy can only ever forward one at a time, so it
            # would never exceed 1 here no matter how many clients race.
            with lock:
                state["inflight"] += 1
                state["max"] = max(state["max"], state["inflight"])
            try:
                time.sleep(UPSTREAM_DELAY)  # hold the connection open
            finally:
                with lock:
                    state["inflight"] -= 1
            body = json.dumps({
                "id": "msg", "type": "message", "role": "assistant",
                "model": "mock", "content": [{"type": "text", "text": "ok"}],
                "stop_reason": "end_turn", "stop_sequence": None,
                "usage": {"input_tokens": 1, "output_tokens": 1},
            }).encode()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)

    return SlowUpstream


def _fire(proxy_port, barrier, results, idx):
    payload = {"model": "claude-x", "max_tokens": 16, "stream": False,
               "messages": [{"role": "user",
                             "content": [{"type": "text", "text": "hi"}]}]}
    req = urllib.request.Request(
        f"http://127.0.0.1:{proxy_port}/v1/messages",
        data=json.dumps(payload).encode(),
        headers={"Content-Type": "application/json"}, method="POST")
    barrier.wait()  # release every client thread at the same instant
    t0 = time.monotonic()
    try:
        with _OPENER.open(req, timeout=30) as r:
            results[idx] = {"status": r.status,
                            "content": json.loads(r.read()).get("content"),
                            "elapsed": time.monotonic() - t0}
    except Exception as exc:  # ConnectionRefused / timeout => record the failure
        results[idx] = {"error": repr(exc)}


def test_proxy_serves_subagent_requests_concurrently(tmp_path):
    state = {"inflight": 0, "max": 0}
    lock = threading.Lock()

    upstream_port = _free_port()
    # The upstream must itself be threaded, otherwise IT would be the thing
    # serialising the forwarded requests and we'd be testing the wrong server.
    # With a threaded upstream the ONLY remaining serialisation point is the
    # proxy under test.
    upstream = ThreadingHTTPServer(("127.0.0.1", upstream_port),
                                   _make_slow_upstream(state, lock))
    threading.Thread(target=upstream.serve_forever, daemon=True).start()

    proxy_port = _free_port()
    prev_logdir = os.environ.get("SYNAXI_LOG_DIR")
    os.environ["SYNAXI_LOG_DIR"] = str(tmp_path / "logs")
    proc = None
    try:
        proc = start_proxy(port=proxy_port,
                           upstream=f"http://127.0.0.1:{upstream_port}",
                           model="mock-model")

        barrier = threading.Barrier(N_CONCURRENT)
        results = [None] * N_CONCURRENT
        threads = [threading.Thread(target=_fire,
                                    args=(proxy_port, barrier, results, i))
                   for i in range(N_CONCURRENT)]
        wall0 = time.monotonic()
        for t in threads:
            t.start()
        for t in threads:
            t.join(timeout=30)
        wall = time.monotonic() - wall0

        # 1. Every request must succeed — no ConnectionRefused, all HTTP 200.
        #    A single-threaded proxy stalls the racers and Claude Code surfaces
        #    that as the "ConnectionRefused" that kills the subagent.
        for i, r in enumerate(results):
            assert r is not None, f"request {i} never completed (join timed out)"
            assert "error" not in r, (
                f"request {i} failed: {r['error']} — this is exactly the "
                f"ConnectionRefused a subagent hits against a single-threaded proxy")
            assert r["status"] == 200 and r["content"], \
                f"request {i}: unexpected response {r}"

        # 2. The crux: a thread-per-connection server lets the slow upstream see
        #    multiple requests in flight at once. A single-threaded proxy could
        #    only forward them one at a time, so max inflight would be exactly 1.
        assert state["max"] >= 2, (
            f"proxy serialised requests (peak concurrent upstream = {state['max']}); "
            f"the subagent scenario needs parent + worker served in parallel")

        # 3. Wall clock corroborates overlap: N serialised requests would take
        #    >= N * UPSTREAM_DELAY; concurrent ones finish in ~1 * UPSTREAM_DELAY.
        assert wall < (N_CONCURRENT - 1) * UPSTREAM_DELAY, (
            f"requests look serialised: {wall:.2f}s wall for {N_CONCURRENT} x "
            f"{UPSTREAM_DELAY}s upstream delay")
    finally:
        stop_proxy(proc)
        upstream.shutdown()
        if prev_logdir is None:
            os.environ.pop("SYNAXI_LOG_DIR", None)
        else:
            os.environ["SYNAXI_LOG_DIR"] = prev_logdir
