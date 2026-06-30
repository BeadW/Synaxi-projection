Feature: Fix a Dijkstra implementation with wrong negative-weight handling and distance tracking
  Complexity: T3
  Category: code/debug
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === graph.py ===
      import heapq

      def dijkstra(graph, start):
          """graph: {node: [(neighbour, weight), ...]}"""
          dist = {node: float('inf') for node in graph}
          dist[start] = 0
          prev = {node: None for node in graph}
          heap = [(0, start)]
          visited = set()

          while heap:
              d, u = heapq.heappop(heap)
              if u in visited:
                  continue
              visited.add(u)
              for v, w in graph.get(u, []):
                  if dist[u] + w < dist[v]:
                      dist[v] = dist[u] + w
                      prev[v] = u
                      heapq.heappush(heap, (dist[v], v))

          return dist, prev

      def shortest_path(graph, start, end):
          dist, prev = dijkstra(graph, start)
          if dist[end] == float('inf'):
              return None, float('inf')
          path = []
          node = end
          while node is not None:
              path.append(node)
              node = prev[node]
          return path, dist[end]

      === test_graph.py ===
      import pytest
      from graph import dijkstra, shortest_path

      SIMPLE = {
          'A': [('B', 1), ('C', 4)],
          'B': [('C', 2), ('D', 5)],
          'C': [('D', 1)],
          'D': [],
      }

      def test_basic_distances():
          dist, _ = dijkstra(SIMPLE, 'A')
          assert dist['A'] == 0
          assert dist['B'] == 1
          assert dist['C'] == 3
          assert dist['D'] == 4

      def test_shortest_path():
          path, cost = shortest_path(SIMPLE, 'A', 'D')
          assert cost == 4
          assert path == ['D', 'C', 'B', 'A']

      def test_unreachable():
          graph = {'A': [], 'B': []}
          _, cost = shortest_path(graph, 'A', 'B')
          assert cost == float('inf')

      def test_single_node():
          graph = {'A': []}
          dist, _ = dijkstra(graph, 'A')
          assert dist['A'] == 0

      def test_node_not_in_graph_raises():
          with pytest.raises((KeyError, ValueError)):
              dijkstra(SIMPLE, 'Z')

      def test_disconnected_components():
          graph = {
              'A': [('B', 2)], 'B': [],
              'C': [('D', 3)], 'D': [],
          }
          dist, _ = dijkstra(graph, 'A')
          assert dist['A'] == 0
          assert dist['B'] == 2
          assert dist['C'] == float('inf')
          assert dist['D'] == float('inf')

      def test_path_returns_correct_order():
          path, _ = shortest_path(SIMPLE, 'A', 'D')
          assert path[0] == 'D'
          assert path[-1] == 'A'

      def test_large_graph():
          import random
          random.seed(42)
          nodes = list(range(20))
          graph = {n: [] for n in nodes}
          for _ in range(60):
              u, v, w = random.randint(0,19), random.randint(0,19), random.randint(1,10)
              if u != v:
                  graph[u].append((v, w))
          # just check it runs without error and start dist is 0
          dist, _ = dijkstra(graph, 0)
          assert dist[0] == 0
      """

  Scenario: Agent fixes all bugs so pytest passes
    Given an agent is tasked with making all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
