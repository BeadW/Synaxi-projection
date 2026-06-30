Feature: Implement a simple LSM-tree key-value store with memtable and SSTables
  Complexity: T4
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === lsm.py ===
      '''
      Simplified LSM-tree (Log-Structured Merge-tree) key-value store.

      Components:
        - MemTable: in-memory sorted dict, flushes to SSTable when full
        - SSTable:  immutable sorted file on disk (use a .sst file in a temp dir)
        - LSMStore: orchestrates writes, reads, compaction

      LSMStore(path, memtable_limit=5):
          put(key: str, value: str) -> None
          get(key: str) -> str | None
          delete(key: str) -> None   (tombstone marker)
          keys() -> list[str]        (all live keys, sorted)
          compact() -> None          (merge all SSTables into one)
      '''

      class LSMStore:
          def __init__(self, path: str, memtable_limit: int = 5):
              pass

          def put(self, key: str, value: str) -> None:
              pass

          def get(self, key: str):
              pass

          def delete(self, key: str) -> None:
              pass

          def keys(self) -> list:
              pass

          def compact(self) -> None:
              pass

      === test_lsm.py ===
      import os
      import tempfile
      import pytest
      from lsm import LSMStore

      @pytest.fixture
      def store(tmp_path):
          return LSMStore(str(tmp_path), memtable_limit=5)

      def test_put_and_get(store):
          store.put('a', '1')
          assert store.get('a') == '1'

      def test_get_missing(store):
          assert store.get('missing') is None

      def test_overwrite(store):
          store.put('k', 'old')
          store.put('k', 'new')
          assert store.get('k') == 'new'

      def test_delete(store):
          store.put('x', 'hello')
          store.delete('x')
          assert store.get('x') is None

      def test_delete_nonexistent(store):
          store.delete('ghost')  # must not raise
          assert store.get('ghost') is None

      def test_flush_to_sstable(store):
          # Insert more than memtable_limit to trigger flush
          for i in range(10):
              store.put(f'key{i:02d}', f'val{i}')
          # All keys must still be readable after flush
          for i in range(10):
              assert store.get(f'key{i:02d}') == f'val{i}'

      def test_keys_sorted(store):
          for k in ['banana', 'apple', 'cherry', 'date']:
              store.put(k, k)
          assert store.keys() == ['apple', 'banana', 'cherry', 'date']

      def test_keys_excludes_deleted(store):
          for k in ['a', 'b', 'c']:
              store.put(k, k)
          store.delete('b')
          assert store.keys() == ['a', 'c']

      def test_keys_after_flush(store):
          for i in range(8):
              store.put(f'k{i}', str(i))
          store.delete('k3')
          assert 'k3' not in store.keys()
          assert len(store.keys()) == 7

      def test_overwrite_after_flush(store):
          for i in range(6):
              store.put('target', f'v{i}')
          assert store.get('target') == 'v5'

      def test_compact_reduces_sstables(tmp_path):
          s = LSMStore(str(tmp_path), memtable_limit=3)
          for i in range(15):
              s.put(f'k{i:02d}', str(i))
          s.compact()
          # After compaction all keys still accessible
          for i in range(15):
              assert s.get(f'k{i:02d}') == str(i)
          # SSTable count should be 1 (or very small)
          sst_files = list(tmp_path.glob('*.sst'))
          assert len(sst_files) <= 2

      def test_compact_removes_tombstones(tmp_path):
          s = LSMStore(str(tmp_path), memtable_limit=3)
          for i in range(10):
              s.put(f'k{i}', str(i))
          for i in range(0, 10, 2):
              s.delete(f'k{i}')
          s.compact()
          for i in range(0, 10, 2):
              assert s.get(f'k{i}') is None
          for i in range(1, 10, 2):
              assert s.get(f'k{i}') == str(i)

      def test_persistence(tmp_path):
          s1 = LSMStore(str(tmp_path), memtable_limit=3)
          for i in range(8):
              s1.put(f'key{i}', f'val{i}')
          del s1
          s2 = LSMStore(str(tmp_path), memtable_limit=3)
          for i in range(8):
              assert s2.get(f'key{i}') == f'val{i}'
      """

  Scenario: Agent implements an LSM-tree store so all tests pass
    Given an agent is tasked with implementing a simplified LSM-tree key-value store in lsm.py with a MemTable that flushes to disk SSTables, supporting put, get, delete (tombstones), keys, and compact so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
