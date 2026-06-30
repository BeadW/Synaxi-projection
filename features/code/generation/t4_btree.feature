Feature: Implement a B-tree with insert, search, delete and range scan
  Complexity: T4
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === btree.py ===
      class BTree:
          '''B-tree of minimum degree t (each non-root node has t-1..2t-1 keys).'''
          def __init__(self, t: int = 2):
              pass

          def insert(self, key) -> None:
              pass

          def search(self, key) -> bool:
              pass

          def delete(self, key) -> None:
              pass

          def range_scan(self, lo, hi) -> list:
              '''Return sorted list of keys k where lo <= k <= hi.'''
              pass

          def to_sorted_list(self) -> list:
              '''Return all keys in sorted order.'''
              pass

      === test_btree.py ===
      import pytest
      import random
      from btree import BTree

      def test_insert_and_search_basic():
          t = BTree(2)
          for k in [10, 20, 5, 6, 12, 30, 7, 17]:
              t.insert(k)
          for k in [10, 20, 5, 6, 12, 30, 7, 17]:
              assert t.search(k), f"missing {k}"
          assert not t.search(99)
          assert not t.search(0)

      def test_sorted_order_after_inserts():
          t = BTree(2)
          keys = [3, 7, 1, 14, 9, 10, 2, 12, 4, 5, 6, 8, 11, 13]
          for k in keys:
              t.insert(k)
          assert t.to_sorted_list() == sorted(keys)

      def test_insert_duplicates_ignored_or_stored():
          t = BTree(2)
          t.insert(5)
          t.insert(5)
          lst = t.to_sorted_list()
          # Either duplicates allowed or silently ignored — just must not crash
          # and search must return True
          assert t.search(5)
          assert 5 in lst

      def test_large_sequential_insert():
          t = BTree(3)
          for k in range(100):
              t.insert(k)
          assert t.to_sorted_list() == list(range(100))
          for k in range(100):
              assert t.search(k)
          assert not t.search(100)

      def test_large_random_insert():
          random.seed(42)
          keys = random.sample(range(1000), 200)
          t = BTree(3)
          for k in keys:
              t.insert(k)
          assert t.to_sorted_list() == sorted(keys)

      def test_delete_leaf_key():
          t = BTree(2)
          for k in [10, 20, 5, 6, 12, 30, 7, 17]:
              t.insert(k)
          t.delete(6)
          assert not t.search(6)
          assert t.to_sorted_list() == sorted([10, 20, 5, 12, 30, 7, 17])

      def test_delete_internal_key():
          t = BTree(2)
          for k in range(1, 16):
              t.insert(k)
          t.delete(8)
          assert not t.search(8)
          expected = [k for k in range(1, 16) if k != 8]
          assert t.to_sorted_list() == expected

      def test_delete_causes_merge():
          t = BTree(2)
          for k in [1, 2, 3, 4, 5, 6, 7]:
              t.insert(k)
          t.delete(1)
          t.delete(2)
          t.delete(3)
          remaining = [4, 5, 6, 7]
          assert t.to_sorted_list() == remaining
          for k in remaining:
              assert t.search(k)

      def test_delete_all_keys():
          t = BTree(2)
          keys = list(range(1, 20))
          for k in keys:
              t.insert(k)
          random.seed(0)
          random.shuffle(keys)
          for k in keys:
              t.delete(k)
          assert t.to_sorted_list() == []

      def test_delete_nonexistent_key():
          t = BTree(2)
          for k in [1, 2, 3]:
              t.insert(k)
          t.delete(99)  # must not raise
          assert t.to_sorted_list() == [1, 2, 3]

      def test_range_scan_basic():
          t = BTree(2)
          for k in range(1, 21):
              t.insert(k)
          assert t.range_scan(5, 10) == [5, 6, 7, 8, 9, 10]

      def test_range_scan_empty():
          t = BTree(2)
          for k in [1, 2, 3, 10, 11]:
              t.insert(k)
          assert t.range_scan(4, 9) == []

      def test_range_scan_full():
          t = BTree(3)
          keys = list(range(50))
          for k in keys:
              t.insert(k)
          assert t.range_scan(0, 49) == keys

      def test_alternating_insert_delete():
          t = BTree(2)
          for k in range(20):
              t.insert(k)
          for k in range(0, 20, 2):
              t.delete(k)
          assert t.to_sorted_list() == list(range(1, 20, 2))
          for k in range(0, 20, 2):
              t.insert(k)
          assert t.to_sorted_list() == list(range(20))
      """

  Scenario: Agent implements a B-tree so all tests pass
    Given an agent is tasked with implementing a B-tree of minimum degree t in btree.py with insert, search, delete (with rebalancing via borrow/merge), range_scan, and to_sorted_list so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
