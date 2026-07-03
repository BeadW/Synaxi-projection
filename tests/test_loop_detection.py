"""Structural action-cycle detection (ProjectionControlState).

The projection agent has no scratchpad, so small models tend to fall into
action cycles (re-running ``ls``, re-reading a file, bouncing between two
actions). ``ProjectionControlState`` detects this *structurally* — the same
action producing the same result again is, by definition, no progress — rather
than pattern-matching sandbox-specific error strings. These tests pin that
behavior, including the critical false-positive guard: the legitimate
``edit -> test -> edit -> test`` loop (whose result changes) must NOT trip it.
"""
from __future__ import annotations

from synaxi_projection.projection import (
    ActionRecord,
    ProjectionControlState,
    build_world_from_messages,
    detect_action_cycle,
)


# ---------------------------------------------------------------------------
# ProjectionControlState — in-process (stateful) behavior
# ---------------------------------------------------------------------------

def test_empty_history_renders_sentinel():
    assert ProjectionControlState().render() == "(none yet)"


def test_distinct_actions_produce_no_hint():
    c = ProjectionControlState()
    c.observe("run_command", {"command": "ls"}, "a.py")
    c.observe("read_file", {"path": "a.py"}, "import x")
    c.observe("run_command", {"command": "python3 -m pytest"}, "1 failed")
    assert c.render() == "(none yet)"


def test_identical_repeat_triggers_and_names_the_action():
    c = ProjectionControlState()  # default threshold = 3
    for _ in range(3):
        c.observe("run_command", {"command": "ls -F"}, "test_x.py")
    out = c.render()
    assert out != "(none yet)"
    assert "ls -F" in out
    assert "not making progress" in out


def test_two_identical_actions_are_not_enough():
    c = ProjectionControlState()
    for _ in range(2):
        c.observe("run_command", {"command": "ls"}, "same")
    assert c.render() == "(none yet)"


def test_changing_result_is_treated_as_progress():
    """The legit edit->test loop: same command, different result each run."""
    c = ProjectionControlState()
    c.observe("run_command", {"command": "pytest"}, "1 failed")
    c.observe("run_command", {"command": "pytest"}, "1 failed, 1 error")
    c.observe("run_command", {"command": "pytest"}, "all passed")
    assert c.render() == "(none yet)"


def test_oscillation_between_two_actions_triggers():
    c = ProjectionControlState()
    for _ in range(3):
        c.observe("run_command", {"command": "ls"}, "a.py")
        c.observe("read_file", {"path": "a.py"}, "import x")
    assert c.render() != "(none yet)"


def test_tool_name_dialects_collapse_to_one_action():
    """`Bash` and `run_command` (and `Read`/`read_file`) are the same action."""
    c = ProjectionControlState()
    c.observe("Bash", {"command": "ls"}, "x")
    c.observe("run_command", {"command": "ls"}, "x")
    c.observe("Bash", {"command": "ls"}, "x")
    assert c.render() != "(none yet)"


def test_untracked_tools_are_ignored():
    c = ProjectionControlState()
    for _ in range(5):
        c.observe("WebSearch", {"query": "foo"}, "results")
    assert c.history == ()
    assert c.render() == "(none yet)"


def test_history_is_exposed_as_readonly_tuple():
    c = ProjectionControlState()
    c.observe("read_file", {"path": "a.py"}, "import x")
    hist = c.history
    assert isinstance(hist, tuple)
    assert len(hist) == 1
    assert hist[0] == ActionRecord("read", "a.py", hist[0].result_hash)


def test_threshold_is_configurable():
    c = ProjectionControlState(repeat_threshold=2)
    c.observe("run_command", {"command": "ls"}, "x")
    c.observe("run_command", {"command": "ls"}, "x")
    assert c.render() != "(none yet)"


def test_whitespace_in_commands_is_normalized():
    c = ProjectionControlState()
    for cmd in ("ls  -F", "ls -F", "ls   -F"):
        c.observe("run_command", {"command": cmd}, "out")
    assert c.render() != "(none yet)"


# ---------------------------------------------------------------------------
# detect_action_cycle — pure function contract
# ---------------------------------------------------------------------------

def test_detector_is_pure_and_handles_empty():
    assert detect_action_cycle([], 3) is None


def test_detector_prefers_shortest_cycle():
    # Four identical records: length-1 repeat should win over length-2.
    rec = ActionRecord("cmd", "ls", "h")
    hint = detect_action_cycle([rec, rec, rec, rec], 3)
    assert hint is not None
    assert "the command `ls`" in hint


# ---------------------------------------------------------------------------
# Proxy path — history reconstructed from the transcript each request
# ---------------------------------------------------------------------------

def _pair(tool_id: str, name: str, inp: dict, result: str):
    return (
        {"role": "assistant",
         "content": [{"type": "tool_use", "id": tool_id, "name": name, "input": inp}]},
        {"role": "user",
         "content": [{"type": "tool_result", "tool_use_id": tool_id, "content": result}]},
    )


def _transcript(steps):
    msgs = [{"role": "user", "content": [{"type": "text", "text": "Task: do it"}]}]
    for i, (name, inp, result) in enumerate(steps):
        assistant, user = _pair(f"t{i}", name, inp, result)
        msgs.append(assistant)
        msgs.append(user)
    return msgs


def test_proxy_transcript_loop_is_detected():
    msgs = _transcript([("Bash", {"command": "ls -F"}, "test_x.py")] * 3)
    _, control, _ = build_world_from_messages(msgs)
    assert control.render() != "(none yet)"


def test_proxy_healthy_transcript_has_no_hint():
    msgs = _transcript([
        ("Bash", {"command": "ls"}, "a.py"),
        ("Read", {"file_path": "a.py"}, "import x"),
        ("Bash", {"command": "python3 -m pytest"}, "1 failed"),
        ("Write", {"file_path": "a.py"}, "written"),
        ("Bash", {"command": "python3 -m pytest"}, "all passed"),
    ])
    _, control, _ = build_world_from_messages(msgs)
    assert control.render() == "(none yet)"


def test_proxy_reconstruction_is_deterministic():
    msgs = _transcript([("Bash", {"command": "ls"}, "same")] * 4)
    first = build_world_from_messages(msgs)[1].render()
    second = build_world_from_messages(msgs)[1].render()
    assert first == second
    assert first != "(none yet)"
