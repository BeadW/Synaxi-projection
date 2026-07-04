"""World-cache budget: hold the working set resident instead of thrashing.

The proxy rebuilds a :class:`WorldCache` from Claude Code's message history on
every request. When that cache is *smaller than the task's working set* it
thrashes: a source file larger than the budget is evicted the turn after it is
read, so the model no longer sees it and re-reads it — every turn. A real
session showed one 8.7 K-token file re-read 87 times, ~89 % of all reads being
re-reads, ~1 M wasted input tokens, and the account's per-minute rate limit
tripping as a result.

These tests pin the fix: the proxy path defaults to a generous
``DEFAULT_WORLD_TOKEN_BUDGET`` that keeps a multi-file working set resident, the
budget is threaded (so the future "pick it intelligently" work has a hook and so
the old constrained behaviour is still reachable), and a projected payload
replays every read file back to the model so it never needs to re-read.
"""
from __future__ import annotations

import json

from synaxi_projection.projection import (
    DEFAULT_WORLD_TOKEN_BUDGET,
    build_world_from_messages,
    project_payload,
)

# ~9 000 tokens each (len // 4). Each file alone exceeds the old 8 000 budget,
# so under that budget it cannot stay resident; three of them (~27 K) sit
# comfortably inside the new default.
BIG = "X" * 36_000
PATHS = ["/repo/a.txt", "/repo/b.txt", "/repo/c.txt"]


def _read_pair(path: str, content: str, idx: int) -> list[dict]:
    tid = f"tid{idx}"
    return [
        {"role": "assistant", "content": [
            {"type": "tool_use", "id": tid, "name": "Read",
             "input": {"file_path": path}}]},
        {"role": "user", "content": [
            {"type": "tool_result", "tool_use_id": tid, "content": content}]},
    ]


def _cmd_pair(command: str, content: str, idx: int) -> list[dict]:
    tid = f"tid{idx}"
    return [
        {"role": "assistant", "content": [
            {"type": "tool_use", "id": tid, "name": "Bash",
             "input": {"command": command}}]},
        {"role": "user", "content": [
            {"type": "tool_result", "tool_use_id": tid, "content": content}]},
    ]


def _history() -> list[dict]:
    """Task, three big file reads, then a small live command pair.

    The final pair is the live stimulus (excluded from the world), so all three
    big files land in the reconstructed world cache.
    """
    msgs: list[dict] = [
        {"role": "user", "content": [
            {"type": "text", "text": "Your task: summarize the docs."}]},
    ]
    for i, p in enumerate(PATHS):
        msgs += _read_pair(p, BIG, i)
    msgs += _cmd_pair("ls", "a.txt\nb.txt\nc.txt\n", len(PATHS))
    return msgs


def test_default_budget_is_generous():
    # The proxy fronts a large-context model, so the default must be well above
    # any single realistic source file (the old 8 000 was a small-model value).
    assert DEFAULT_WORLD_TOKEN_BUDGET >= 64_000


def test_default_budget_keeps_multifile_working_set_resident():
    world, _control, _pairs = build_world_from_messages(_history())
    for p in PATHS:
        assert world.get(p) is not None, (
            f"{p} was evicted at the default budget — the working set should "
            f"stay resident so the model never has to re-read it")


def test_small_budget_still_thrashes_old_behaviour():
    # With the old 8 000 budget, files larger than the budget cannot all stay
    # resident — this is the thrash the new default fixes. Pinning it proves the
    # budget is honoured and documents *why* 8 000 was the problem.
    world, _control, _pairs = build_world_from_messages(_history(), token_budget=8000)
    resident = [p for p in PATHS if world.get(p) is not None]
    assert len(resident) < len(PATHS)


def test_projected_payload_replays_every_read_file():
    # End-to-end: after projection the model receives each file it read back as
    # a native tool pair, so it has no reason to re-read any of them.
    payload = {
        "model": "claude-x",
        "max_tokens": 1024,
        "system": [{"type": "text",
                    "text": "You are Claude Code, Anthropic's official CLI for Claude."}],
        "messages": _history(),
        "tools": [{"name": "Read", "input_schema": {"type": "object"}},
                  {"name": "Bash", "input_schema": {"type": "object"}}],
    }
    out = project_payload(dict(payload), preserve_claude_identity=False)
    blob = json.dumps(out["messages"])
    for p in PATHS:
        assert p in blob, (
            f"{p} was not replayed into the projected context — the model would "
            f"re-read it and thrash")


def test_world_token_budget_override_is_threaded():
    # The project_payload hook the future "intelligent budget" work will use:
    # a tiny override reproduces the constrained (thrashing) behaviour, proving
    # the value flows all the way through to the WorldCache.
    payload = {
        "model": "claude-x",
        "max_tokens": 1024,
        "system": [{"type": "text",
                    "text": "You are Claude Code, Anthropic's official CLI for Claude."}],
        "messages": _history(),
        "tools": [{"name": "Read", "input_schema": {"type": "object"}}],
    }
    tight = project_payload(dict(payload), preserve_claude_identity=False,
                            world_token_budget=8000)
    roomy = project_payload(dict(payload), preserve_claude_identity=False,
                            world_token_budget=DEFAULT_WORLD_TOKEN_BUDGET)
    tight_hits = sum(p in json.dumps(tight["messages"]) for p in PATHS)
    roomy_hits = sum(p in json.dumps(roomy["messages"]) for p in PATHS)
    assert roomy_hits == len(PATHS)
    assert tight_hits < roomy_hits
