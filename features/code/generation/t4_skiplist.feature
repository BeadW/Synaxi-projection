Feature: Implement a skip list with O(log n) insert, search, delete and range queries
  Complexity: T4
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === skiplist.py ===
      '''
      Probabilistic skip list (p=0.5) supporting:
        insert(key, value=None)
        search(key) -> value | None  (None if not found)
        delete(key) -> bool          (True if removed, False if not found)
        range_query(lo, hi) -> list[(key, value)]  sorted by key, inclusive
        __len__() -> int
        __iter__()  yields keys in sorted order
      '''
      import random

      class SkipList:
          def __init__(self, max_level: int = 16, p: float = 0.5):
              pass

          def insert(self, key, value=None) -> None:
              pass

          def search(self, key):
              pass

          def delete(self, key) -> bool:
              pass

          def range_query(self, lo, hi) -> list:
              pass

          def __len__(self) -> int:
              pass

          def __iter__(self):
              pass

      === test_skiplist.py ===
      import pytest
      import random
      from skiplist import SkipList

      def test_insert_and_search():
          sl = SkipList()
          sl.insert(3, 'three')
          sl.insert(1, 'one')
          sl.insert(2, 'two')
          assert sl.search(1) == 'one'
          assert sl.search(2) == 'two'
          assert sl.search(3) == 'three'
          assert sl.search(99) is None

      def test_insert_no_value():
          sl = SkipList()
          sl.insert(5)
          assert sl.search(5) is None  # value defaults to None, key exists
          # But len should reflect insertion
          assert len(sl) == 1

      def test_update_existing_key():
          sl = SkipList()
          sl.insert(1, 'a')
          sl.insert(1, 'b')
          assert sl.search(1) == 'b'
          assert len(sl) == 1  # no duplicate keys

      def test_delete_existing():
          sl = SkipList()
          for k in [1, 2, 3, 4, 5]:
              sl.insert(k, k*10)
          assert sl.delete(3) is True
          assert sl.search(3) is None
          assert len(sl) == 4

      def test_delete_nonexistent():
          sl = SkipList()
          sl.insert(1, 'a')
          assert sl.delete(99) is False
          assert len(sl) == 1

      def test_delete_all():
          sl = SkipList()
          for k in range(10):
              sl.insert(k)
          for k in range(10):
              sl.delete(k)
          assert len(sl) == 0

      def test_len():
          sl = SkipList()
          assert len(sl) == 0
          for i in range(5):
              sl.insert(i)
          assert len(sl) == 5
          sl.delete(2)
          assert len(sl) == 4

      def test_iter_sorted():
          sl = SkipList()
          keys = [5, 2, 8, 1, 9, 3]
          for k in keys:
              sl.insert(k, k)
          assert list(sl) == sorted(keys)

      def test_range_query_basic():
          sl = SkipList()
          for k in range(1, 11):
              sl.insert(k, k*2)
          result = sl.range_query(3, 7)
          assert [k for k, v in result] == [3, 4, 5, 6, 7]
          assert [v for k, v in result] == [6, 8, 10, 12, 14]

      def test_range_query_empty():
          sl = SkipList()
          for k in [1, 2, 10, 11]:
              sl.insert(k)
          assert sl.range_query(3, 9) == []

      def test_range_query_single():
          sl = SkipList()
          for k in range(10):
              sl.insert(k)
          assert sl.range_query(5, 5) == [(5, None)]

      def test_large_insert_sorted():
          random.seed(42)
          sl = SkipList()
          keys = random.sample(range(1000), 300)
          for k in keys:
              sl.insert(k, k)
          assert list(sl) == sorted(keys)
          assert len(sl) == 300

      def test_large_delete():
          sl = SkipList()
          for k in range(100):
              sl.insert(k, k)
          for k in range(0, 100, 2):
              sl.delete(k)
          assert list(sl) == list(range(1, 100, 2))

      def test_interleaved_ops():
          sl = SkipList()
          sl.insert(5, 'five')
          sl.insert(3, 'three')
          sl.insert(7, 'seven')
          sl.delete(3)
          sl.insert(4, 'four')
          assert list(sl) == [4, 5, 7]
          assert sl.search(3) is None
          assert sl.search(4) == 'four'
      """

  Scenario: Agent implements a skip list so all tests pass
    Given an agent is tasked with implementing a probabilistic skip list in skiplist.py with insert, search, delete, range_query, __len__, and __iter__ maintaining sorted order so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
