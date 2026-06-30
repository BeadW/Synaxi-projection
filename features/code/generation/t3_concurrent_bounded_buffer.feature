Feature: Implement a thread-safe bounded buffer (blocking producer-consumer)
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === test_buffer.py ===
      import threading
      import time
      import pytest
      from bounded_buffer import BoundedBuffer

      def test_basic_put_get():
          b = BoundedBuffer(3)
          b.put(1)
          b.put(2)
          assert b.get() == 1
          assert b.get() == 2

      def test_fifo_order():
          b = BoundedBuffer(5)
          for i in range(5):
              b.put(i)
          for i in range(5):
              assert b.get() == i

      def test_blocks_when_full():
          b = BoundedBuffer(2)
          b.put("a")
          b.put("b")
          unblocked = threading.Event()
          def producer():
              b.put("c")       # should block until a slot is free
              unblocked.set()
          t = threading.Thread(target=producer)
          t.start()
          time.sleep(0.05)
          assert not unblocked.is_set(), "put should have blocked"
          b.get()              # free a slot
          t.join(timeout=1.0)
          assert unblocked.is_set(), "put should have unblocked after get"

      def test_blocks_when_empty():
          b = BoundedBuffer(2)
          result = []
          def consumer():
              result.append(b.get())   # should block until item available
          t = threading.Thread(target=consumer)
          t.start()
          time.sleep(0.05)
          assert result == [], "get should have blocked"
          b.put(42)
          t.join(timeout=1.0)
          assert result == [42]

      def test_concurrent_producers_consumers():
          b = BoundedBuffer(4)
          produced = list(range(20))
          consumed = []
          lock = threading.Lock()

          def producer(items):
              for x in items:
                  b.put(x)

          def consumer(n):
              for _ in range(n):
                  with lock:
                      consumed.append(b.get())

          threads = (
              [threading.Thread(target=producer, args=(produced[i::4],)) for i in range(4)] +
              [threading.Thread(target=consumer, args=(5,)) for _ in range(4)]
          )
          for t in threads: t.start()
          for t in threads: t.join(timeout=5.0)

          assert sorted(consumed) == produced

      def test_size():
          b = BoundedBuffer(3)
          assert b.size() == 0
          b.put(1)
          b.put(2)
          assert b.size() == 2
          b.get()
          assert b.size() == 1
      """

  Scenario: Agent implements BoundedBuffer so all tests pass
    Given an agent is tasked with implementing bounded_buffer.py with a thread-safe BoundedBuffer(capacity) class that blocks producers when full and consumers when empty, with put(item), get(), and size() methods, so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
