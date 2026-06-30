Feature: Implement a graph module with Dijkstra, topological sort, SCC, and cycle detection
  Complexity: T4
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === graph.py ===
      '''
      Weighted directed graph with:
        - dijkstra(src) -> dict[node, dist]
        - shortest_path(src, dst) -> list[node] | None
        - topological_sort() -> list[node]   (raises CycleError if cycle)
        - has_cycle() -> bool
        - strongly_connected_components() -> list[set]  (Kosaraju or Tarjan)
        - is_bipartite() -> bool  (treats graph as undirected)

      CycleError(Exception) must be importable.
      '''

      class CycleError(Exception):
          pass

      class Graph:
          def __init__(self):
              pass

          def add_edge(self, u, v, weight: float = 1.0) -> None:
              pass

          def add_node(self, node) -> None:
              pass

          def dijkstra(self, src) -> dict:
              pass

          def shortest_path(self, src, dst) -> list:
              pass

          def topological_sort(self) -> list:
              pass

          def has_cycle(self) -> bool:
              pass

          def strongly_connected_components(self) -> list:
              pass

          def is_bipartite(self) -> bool:
              pass

      === test_graph.py ===
      import pytest
      from graph import Graph, CycleError

      # ── Dijkstra ────────────────────────────────────────────────────────────

      def test_dijkstra_simple():
          g = Graph()
          g.add_edge('A', 'B', 1)
          g.add_edge('A', 'C', 4)
          g.add_edge('B', 'C', 2)
          g.add_edge('B', 'D', 5)
          g.add_edge('C', 'D', 1)
          d = g.dijkstra('A')
          assert d['A'] == 0
          assert d['B'] == 1
          assert d['C'] == 3
          assert d['D'] == 4

      def test_dijkstra_unreachable():
          g = Graph()
          g.add_edge('A', 'B', 1)
          g.add_node('C')
          d = g.dijkstra('A')
          assert d['B'] == 1
          assert d['C'] == float('inf')

      def test_shortest_path():
          g = Graph()
          g.add_edge('A', 'B', 1)
          g.add_edge('A', 'C', 10)
          g.add_edge('B', 'C', 1)
          path = g.shortest_path('A', 'C')
          assert path == ['A', 'B', 'C']

      def test_shortest_path_none():
          g = Graph()
          g.add_edge('A', 'B', 1)
          g.add_node('C')
          assert g.shortest_path('A', 'C') is None

      def test_shortest_path_self():
          g = Graph()
          g.add_edge('A', 'B', 1)
          assert g.shortest_path('A', 'A') == ['A']

      # ── Topological sort ───────────────────────────────────────────────────

      def test_toposort_simple():
          g = Graph()
          g.add_edge('A', 'B')
          g.add_edge('B', 'C')
          order = g.topological_sort()
          assert order.index('A') < order.index('B')
          assert order.index('B') < order.index('C')

      def test_toposort_diamond():
          g = Graph()
          g.add_edge('A', 'B')
          g.add_edge('A', 'C')
          g.add_edge('B', 'D')
          g.add_edge('C', 'D')
          order = g.topological_sort()
          assert order.index('A') < order.index('B')
          assert order.index('A') < order.index('C')
          assert order.index('B') < order.index('D')
          assert order.index('C') < order.index('D')

      def test_toposort_raises_on_cycle():
          g = Graph()
          g.add_edge('A', 'B')
          g.add_edge('B', 'C')
          g.add_edge('C', 'A')
          with pytest.raises(CycleError):
              g.topological_sort()

      # ── Cycle detection ────────────────────────────────────────────────────

      def test_has_cycle_true():
          g = Graph()
          g.add_edge('A', 'B')
          g.add_edge('B', 'C')
          g.add_edge('C', 'A')
          assert g.has_cycle() is True

      def test_has_cycle_false():
          g = Graph()
          g.add_edge('A', 'B')
          g.add_edge('A', 'C')
          g.add_edge('B', 'D')
          assert g.has_cycle() is False

      def test_has_cycle_self_loop():
          g = Graph()
          g.add_edge('A', 'A')
          assert g.has_cycle() is True

      # ── SCC ────────────────────────────────────────────────────────────────

      def test_scc_simple():
          g = Graph()
          g.add_edge(1, 2)
          g.add_edge(2, 3)
          g.add_edge(3, 1)
          g.add_edge(3, 4)
          sccs = g.strongly_connected_components()
          scc_sets = [frozenset(s) for s in sccs]
          assert frozenset({1, 2, 3}) in scc_sets
          assert frozenset({4}) in scc_sets

      def test_scc_no_edges():
          g = Graph()
          for n in [1, 2, 3]:
              g.add_node(n)
          sccs = g.strongly_connected_components()
          assert len(sccs) == 3
          assert all(len(s) == 1 for s in sccs)

      def test_scc_full_cycle():
          g = Graph()
          for i in range(5):
              g.add_edge(i, (i+1) % 5)
          sccs = g.strongly_connected_components()
          assert len(sccs) == 1
          assert set(sccs[0]) == {0, 1, 2, 3, 4}

      # ── Bipartite ──────────────────────────────────────────────────────────

      def test_bipartite_even_cycle():
          g = Graph()
          for i in range(6):
              g.add_edge(i, (i+1) % 6)
          assert g.is_bipartite() is True

      def test_not_bipartite_odd_cycle():
          g = Graph()
          for i in range(5):
              g.add_edge(i, (i+1) % 5)
          assert g.is_bipartite() is False

      def test_bipartite_complete_bipartite():
          g = Graph()
          for u in [0, 1, 2]:
              for v in [3, 4, 5]:
                  g.add_edge(u, v)
          assert g.is_bipartite() is True
      """

  Scenario: Agent implements a graph module so all tests pass
    Given an agent is tasked with implementing graph.py with a Graph class supporting dijkstra, shortest_path, topological_sort (raising CycleError on cycles), has_cycle, strongly_connected_components, and is_bipartite so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
