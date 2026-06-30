Feature: LiveCodeBench/atcoder/hard — Flip Edge
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a directed graph with N vertices and M edges.
      The i-th edge (1 \leq i \leq M) is a directed edge from vertex u _ i to vertex v _ i.
      Initially, you are at vertex 1. You want to repeat the following operations until you reach vertex N:

      - Perform one of the two operations below:
      - Move along a directed edge from your current vertex. This incurs a cost of 1. More precisely, if you are at vertex v, choose a vertex u such that there is a directed edge from v to u, and move to vertex u.
      - Reverse the direction of all edges. This incurs a cost of X. More precisely, if and only if there was a directed edge from v to u immediately before this operation, there is a directed edge from u to v immediately after this operation.



      It is guaranteed that, for the given graph, you can reach vertex N from vertex 1 by repeating these operations.
      Find the minimum total cost required to reach vertex N.

      Input

      The input is given from Standard Input in the following format:
      N M X
      u _ 1 v _ 1
      u _ 2 v _ 2
      \vdots
      u _ M v _ M

      Output

      Print the minimum total cost required to reach vertex N.

      Constraints


      - 2 \leq N \leq 2 \times 10^5
      - 1 \leq M \leq 2 \times 10^5
      - 1 \leq X \leq 10^9
      - 1 \leq u _ i \leq N \ (1 \leq i \leq M)
      - 1 \leq v _ i \leq N \ (1 \leq i \leq M)
      - For the given graph, it is guaranteed that you can reach vertex N from vertex 1 by the operations described.
      - All input values are integers.

      Sample Input 1

      5 6 5
      1 2
      2 4
      3 1
      3 5
      4 3
      5 2

      Sample Output 1

      4

      The given graph looks like this:

      You can reach vertex 5 with a total cost of 4 by doing the following:

      - Move to vertex 2 at a cost of 1.
      - Move to vertex 4 at a cost of 1.
      - Move to vertex 3 at a cost of 1.
      - Move to vertex 5 at a cost of 1.

      It is impossible to reach vertex 5 with a total cost of 3 or less, so print 4.

      Sample Input 2

      5 6 1
      1 2
      2 4
      3 1
      3 5
      4 3
      5 2

      Sample Output 2

      3

      The graph is the same as in Sample 1, but the cost to reverse edges is different.
      You can reach vert

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5 6 5\n1 2\n2 4\n3 1\n3 5\n4 3\n5 2",
              "4"
          ],
          [
              "5 6 1\n1 2\n2 4\n3 1\n3 5\n4 3\n5 2",
              "3"
          ],
          [
              "8 7 613566756\n2 1\n2 3\n4 3\n4 5\n6 5\n6 7\n8 7",
              "4294967299"
          ],
          [
              "20 13 5\n1 3\n14 18\n18 17\n12 19\n3 5\n4 6\n13 9\n8 5\n14 2\n20 18\n8 14\n4 9\n14 8",
              "21"
          ]
      ]


      def test_lcb():
          for i, (inp, expected) in enumerate(TEST_CASES):
              r = subprocess.run(
                  [sys.executable, "solution.py"],
                  input=inp,
                  capture_output=True,
                  text=True,
                  timeout=10,
              )
              assert r.returncode == 0, f"Case {i}: runtime error\n{r.stderr[:400]}"
              assert r.stdout.strip() == expected.strip(), (
                  f"Case {i}: expected {expected!r}, got {r.stdout!r}"
              )

      """

  Scenario: Agent solves the LiveCodeBench problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
