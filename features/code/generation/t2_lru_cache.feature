Feature: Generate an LRU cache class
  Complexity: T2
  Category: code/generation

  Scenario: Agent writes a working LRU cache with get and put
    Given an agent is tasked with writing a Python class called LRUCache with a constructor taking capacity, a get(key) method returning -1 if missing, and a put(key, value) method that evicts the least recently used item when over capacity
    When the agent completes the task
    Then the code execution script passes:
      """
      cache = LRUCache(2)
      cache.put(1, 1)
      cache.put(2, 2)
      assert cache.get(1) == 1
      cache.put(3, 3)
      assert cache.get(2) == -1
      cache.put(4, 4)
      assert cache.get(1) == -1
      assert cache.get(3) == 3
      assert cache.get(4) == 4
      """
