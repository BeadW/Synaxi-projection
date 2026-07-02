"""Cache-aware projection: prefix byte-stability.

Anthropic prompt caching only pays off if the cached region is *byte-identical*
turn to turn. Projection rebuilds the message array every turn, so this test
proves that the region before the moving breakpoint (system + tools + goal +
older world observations) reappears verbatim as the world grows by one pair —
which is exactly what lets Anthropic re-read it at 0.1x instead of re-writing it.
"""
from __future__ import annotations

import json

from synaxi_projection.projection import project_payload


def _payload_with_pairs(n_pairs: int):
    """Claude Code payload with ``n_pairs`` completed reads of distinct files."""
    msgs = [{"role": "user", "content": "Your task: make the tests pass."}]
    for i in range(n_pairs):
        tid = f"t{i}"
        msgs.append({"role": "assistant", "content": [
            {"type": "tool_use", "id": tid, "name": "Read",
             "input": {"file_path": f"file_{i}.py"}}]})
        msgs.append({"role": "user", "content": [
            {"type": "tool_result", "tool_use_id": tid,
             "content": f"# contents of file_{i}.py\n" + ("x = 1\n" * 20)}]})
    return {
        "model": "claude-haiku-4-5",
        "system": [
            {"type": "text",
             "text": "You are Claude Code, Anthropic's official CLI for Claude."},
            {"type": "text", "text": "BIG SYSTEM " * 200,
             "cache_control": {"type": "ephemeral"}},
        ],
        "tools": [
            {"name": "Read", "input_schema": {"type": "object"}},
            {"name": "Write", "input_schema": {"type": "object"}},
            {"name": "Edit", "input_schema": {"type": "object"}},
            {"name": "Bash", "input_schema": {"type": "object"}},
        ],
        "messages": msgs,
    }


def _stable_prefix(payload):
    """Serialize everything up to and including the LAST cache_control breakpoint.

    That prefix is what Anthropic caches; drop the final (moving) segment to get
    the region that must be byte-identical to the previous turn.
    """
    parts = []
    for b in payload["system"] if isinstance(payload["system"], list) else []:
        parts.append(json.dumps(b, sort_keys=True))
        if "cache_control" in b:
            break
    for tdef in payload.get("tools") or []:
        parts.append(json.dumps(tdef, sort_keys=True))
        if "cache_control" in tdef:
            break
    msgs = payload["messages"]
    cut = -1
    for i, m in enumerate(msgs):
        c = m.get("content")
        if isinstance(c, list) and any(
            isinstance(b, dict) and "cache_control" in b for b in c
        ):
            cut = i
    for m in (msgs[: cut + 1] if cut >= 0 else []):
        parts.append(json.dumps(m, sort_keys=True))
    return parts


def test_stable_prefix_is_byte_identical_across_turns():
    p_a = project_payload(_payload_with_pairs(5), preserve_claude_identity=True)
    p_b = project_payload(_payload_with_pairs(6), preserve_claude_identity=True)

    pref_a = _stable_prefix(p_a)
    # Turn N's cached region (minus its own moving final segment) must be a
    # verbatim prefix of turn N+1's serialized stable prefix.
    cached_a = "\n".join(pref_a[:-1])
    full_b = "\n".join(_stable_prefix(p_b))

    assert cached_a, "expected a non-empty cached prefix"
    assert full_b.startswith(cached_a), "stable prefix broke -> cache would miss"
