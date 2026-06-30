Feature: Generate an event emitter with multiple listener support
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === test_event_emitter.py ===
      import pytest
      from event_emitter import EventEmitter

      def test_on_and_emit():
          ee = EventEmitter()
          received = []
          ee.on("data", lambda x: received.append(x))
          ee.emit("data", 42)
          assert received == [42]

      def test_multiple_listeners():
          ee = EventEmitter()
          log = []
          ee.on("click", lambda: log.append("a"))
          ee.on("click", lambda: log.append("b"))
          ee.emit("click")
          assert log == ["a", "b"]

      def test_once():
          ee = EventEmitter()
          count = [0]
          ee.once("ping", lambda: count.__setitem__(0, count[0] + 1))
          ee.emit("ping")
          ee.emit("ping")
          assert count[0] == 1

      def test_off():
          ee = EventEmitter()
          log = []
          fn = lambda x: log.append(x)
          ee.on("msg", fn)
          ee.emit("msg", "hello")
          ee.off("msg", fn)
          ee.emit("msg", "world")
          assert log == ["hello"]

      def test_no_listeners():
          ee = EventEmitter()
          ee.emit("nothing")  # should not raise

      def test_emit_with_multiple_args():
          ee = EventEmitter()
          received = []
          ee.on("data", lambda a, b: received.append((a, b)))
          ee.emit("data", 1, 2)
          assert received == [(1, 2)]
      """

  Scenario: Agent implements EventEmitter so all tests pass
    Given an agent is tasked with implementing event_emitter.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
