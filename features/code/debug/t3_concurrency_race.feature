Feature: Fix a race condition in a counter using threads
  Complexity: T3
  Category: code/debug

  Background:
    Given the following broken Python code:
      """
      import threading

      class Counter:
          def __init__(self):
              self.value = 0

          def increment(self):
              current = self.value
              self.value = current + 1
      """

  Scenario: Agent produces a thread-safe counter
    Given an agent is tasked with fixing the bug
    When the agent completes the task
    Then the code execution script passes:
      """
      import threading

      counter = Counter()
      threads = [threading.Thread(target=counter.increment) for _ in range(1000)]
      for t in threads:
          t.start()
      for t in threads:
          t.join()
      assert counter.value == 1000, f"Expected 1000, got {counter.value}"
      """
