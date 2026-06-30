Feature: Implement an LFU (Least Frequently Used) cache
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === test_lfu.py ===
      import pytest
      from lfu import LFUCache

      def test_basic_get_put():
          c = LFUCache(2)
          c.put(1, 10)
          c.put(2, 20)
          assert c.get(1) == 10
          assert c.get(2) == 20

      def test_evict_least_frequent():
          c = LFUCache(2)
          c.put(1, 10)
          c.put(2, 20)
          c.get(1)      # freq(1)=2, freq(2)=1
          c.put(3, 30)  # evicts key 2 (lowest freq)
          assert c.get(2) == -1
          assert c.get(1) == 10
          assert c.get(3) == 30

      def test_tie_broken_by_lru():
          c = LFUCache(2)
          c.put(1, 10)
          c.put(2, 20)  # both freq=1, key 1 is older
          c.put(3, 30)  # evicts key 1 (freq tie, LRU)
          assert c.get(1) == -1
          assert c.get(2) == 20
          assert c.get(3) == 30

      def test_update_existing_key():
          c = LFUCache(2)
          c.put(1, 10)
          c.put(1, 100)  # update value, freq increases
          assert c.get(1) == 100
          c.put(2, 20)
          c.put(3, 30)   # evicts key 2 (freq=1), not key 1 (freq=3)
          assert c.get(1) == 100
          assert c.get(2) == -1

      def test_capacity_one():
          c = LFUCache(1)
          c.put(1, 10)
          c.put(2, 20)
          assert c.get(1) == -1
          assert c.get(2) == 20

      def test_get_updates_frequency():
          c = LFUCache(3)
          for k in [1, 2, 3]:
              c.put(k, k * 10)
          for _ in range(3):
              c.get(1)   # freq(1)=4
          for _ in range(2):
              c.get(2)   # freq(2)=3
          # freq(3)=1 — should be evicted next
          c.put(4, 40)
          assert c.get(3) == -1
          assert c.get(1) == 10
          assert c.get(2) == 20
          assert c.get(4) == 40

      def test_zero_capacity():
          c = LFUCache(0)
          c.put(1, 1)
          assert c.get(1) == -1

      def test_many_operations():
          c = LFUCache(3)
          for i in range(10):
              c.put(i, i * 100)
          # only last 3 should be reachable (roughly), but freq-based eviction may differ
          # just assert no crash and get returns int
          for i in range(10):
              result = c.get(i)
              assert isinstance(result, int)
      """

  Scenario: Agent implements LFUCache so all tests pass
    Given an agent is tasked with implementing lfu.py with an LFUCache(capacity) class that has get(key) returning -1 if missing and put(key, value) with O(1) LFU eviction so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
