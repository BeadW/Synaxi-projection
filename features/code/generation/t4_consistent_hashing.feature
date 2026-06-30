Feature: Implement a consistent hash ring with virtual nodes
  Complexity: T4
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === hashring.py ===
      '''
      Consistent hash ring with virtual nodes for even distribution.

      HashRing(replicas=100):
          add_node(node: str) -> None
          remove_node(node: str) -> None
          get_node(key: str) -> str   # returns node responsible for key
          get_nodes(key: str, n: int) -> list[str]  # n distinct nodes in preference order
          distribution() -> dict[str, int]  # {node: num_virtual_slots}
      '''

      class HashRing:
          def __init__(self, replicas: int = 100):
              pass

          def add_node(self, node: str) -> None:
              pass

          def remove_node(self, node: str) -> None:
              pass

          def get_node(self, key: str) -> str:
              pass

          def get_nodes(self, key: str, n: int) -> list:
              pass

          def distribution(self) -> dict:
              pass

      === test_hashring.py ===
      import pytest
      from hashring import HashRing

      def test_single_node_gets_all_keys():
          ring = HashRing(replicas=10)
          ring.add_node('A')
          for key in ['foo', 'bar', 'baz', 'hello', 'world']:
              assert ring.get_node(key) == 'A'

      def test_two_nodes_split_keys():
          ring = HashRing(replicas=100)
          ring.add_node('A')
          ring.add_node('B')
          keys = [str(i) for i in range(200)]
          assignments = {ring.get_node(k) for k in keys}
          assert assignments == {'A', 'B'}

      def test_add_node_returns_correct_type():
          ring = HashRing()
          ring.add_node('server1')
          ring.add_node('server2')
          result = ring.get_node('some-key')
          assert isinstance(result, str)
          assert result in ('server1', 'server2')

      def test_remove_node_reassigns():
          ring = HashRing(replicas=100)
          ring.add_node('A')
          ring.add_node('B')
          ring.add_node('C')
          key = 'test-key'
          original = ring.get_node(key)
          ring.remove_node(original)
          new_node = ring.get_node(key)
          assert new_node != original
          assert new_node in ('A', 'B', 'C')

      def test_stability_adding_node():
          ring = HashRing(replicas=150)
          ring.add_node('A')
          ring.add_node('B')
          keys = [str(i) for i in range(500)]
          before = {k: ring.get_node(k) for k in keys}
          ring.add_node('C')
          after = {k: ring.get_node(k) for k in keys}
          # Keys that moved should only move to C
          moved = [k for k in keys if before[k] != after[k]]
          for k in moved:
              assert after[k] == 'C', f"key {k} moved from {before[k]} to {after[k]} (not C)"
          # At least some keys should stay (not everything should move)
          stayed = len(keys) - len(moved)
          assert stayed > len(keys) // 3

      def test_stability_removing_node():
          ring = HashRing(replicas=150)
          for n in ['A', 'B', 'C']:
              ring.add_node(n)
          keys = [str(i) for i in range(500)]
          before = {k: ring.get_node(k) for k in keys}
          ring.remove_node('C')
          after = {k: ring.get_node(k) for k in keys}
          # Keys that moved must have been on C before
          moved = [k for k in keys if before[k] != after[k]]
          for k in moved:
              assert before[k] == 'C', f"key {k} moved but was on {before[k]}"

      def test_get_nodes_returns_n_distinct():
          ring = HashRing(replicas=50)
          for n in ['A', 'B', 'C', 'D']:
              ring.add_node(n)
          nodes = ring.get_nodes('mykey', 3)
          assert len(nodes) == 3
          assert len(set(nodes)) == 3  # all distinct

      def test_get_nodes_all():
          ring = HashRing(replicas=50)
          for n in ['A', 'B', 'C']:
              ring.add_node(n)
          nodes = ring.get_nodes('mykey', 3)
          assert set(nodes) == {'A', 'B', 'C'}

      def test_get_nodes_more_than_available():
          ring = HashRing(replicas=50)
          ring.add_node('A')
          ring.add_node('B')
          nodes = ring.get_nodes('mykey', 5)
          assert len(nodes) == 2  # can't return more than exist
          assert set(nodes) == {'A', 'B'}

      def test_distribution_virtual_nodes():
          ring = HashRing(replicas=100)
          for n in ['A', 'B', 'C']:
              ring.add_node(n)
          dist = ring.distribution()
          assert set(dist.keys()) == {'A', 'B', 'C'}
          for v in dist.values():
              assert v == 100

      def test_distribution_after_remove():
          ring = HashRing(replicas=50)
          for n in ['A', 'B', 'C']:
              ring.add_node(n)
          ring.remove_node('B')
          dist = ring.distribution()
          assert 'B' not in dist
          assert set(dist.keys()) == {'A', 'C'}

      def test_empty_ring_raises():
          ring = HashRing()
          with pytest.raises((IndexError, ValueError, KeyError)):
              ring.get_node('any-key')

      def test_deterministic():
          ring1 = HashRing(replicas=100)
          ring2 = HashRing(replicas=100)
          for n in ['X', 'Y', 'Z']:
              ring1.add_node(n)
              ring2.add_node(n)
          keys = ['a', 'b', 'c', 'd', 'e']
          assert [ring1.get_node(k) for k in keys] == [ring2.get_node(k) for k in keys]
      """

  Scenario: Agent implements a consistent hash ring so all tests pass
    Given an agent is tasked with implementing a consistent hash ring with virtual nodes in hashring.py with add_node, remove_node, get_node, get_nodes, and distribution methods satisfying the stability and distribution properties so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
