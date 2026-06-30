Feature: Generate a file-backed persistent task queue
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === test_queue.py ===
      import pytest
      import tempfile
      import os
      from queue_impl import PersistentQueue

      @pytest.fixture
      def queue(tmp_path):
          return PersistentQueue(tmp_path / "queue.db")

      def test_enqueue_and_dequeue(queue):
          queue.enqueue({"task": "send_email", "to": "a@b.com"})
          queue.enqueue({"task": "resize_image", "path": "/tmp/img.png"})
          item = queue.dequeue()
          assert item["task"] == "send_email"
          item2 = queue.dequeue()
          assert item2["task"] == "resize_image"

      def test_fifo_order(queue):
          for i in range(5):
              queue.enqueue({"n": i})
          for i in range(5):
              assert queue.dequeue()["n"] == i

      def test_empty_returns_none(queue):
          assert queue.dequeue() is None

      def test_persistence(tmp_path):
          path = tmp_path / "q.db"
          q1 = PersistentQueue(path)
          q1.enqueue({"x": 1})
          q1.enqueue({"x": 2})
          del q1
          q2 = PersistentQueue(path)
          assert q2.dequeue()["x"] == 1
          assert q2.dequeue()["x"] == 2
          assert q2.dequeue() is None

      def test_len(queue):
          assert len(queue) == 0
          queue.enqueue({"a": 1})
          queue.enqueue({"a": 2})
          assert len(queue) == 2
          queue.dequeue()
          assert len(queue) == 1

      def test_clear(queue):
          queue.enqueue({"a": 1})
          queue.clear()
          assert len(queue) == 0
          assert queue.dequeue() is None
      """

  Scenario: Agent implements PersistentQueue so all tests pass
    Given an agent is tasked with implementing queue_impl.py with a PersistentQueue class backed by a file so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
