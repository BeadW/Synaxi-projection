Feature: LiveCodeBench/atcoder/hard — Maximize Distance
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a directed graph with N vertices and M edges. The vertices are numbered 1,2,\dots,N. Edge j (j=1,2,\dots,M) goes from vertex u_j to vertex v_j. It is guaranteed that vertex N is reachable from vertex 1.
      Initially, all edges have weight 0. We choose exactly K out of the M edges and change their weights to 1. Find the maximum possible value of the shortest distance from vertex 1 to vertex N in the resulting graph.

      Input

      The input is given from Standard Input in the following format:
      N M K
      u_1 v_1
      u_2 v_2
      \vdots
      u_M v_M

      Output

      Print the answer.

      Constraints


      - 2 \leq N \leq 30
      - 1 \leq K \leq M \leq 100
      - 1 \leq u_j, v_j \leq N
      - u_j \neq v_j
      - In the given graph, vertex N is reachable from vertex 1.
      - All input values are integers.

      Sample Input 1

      3 3 2
      1 2
      2 3
      1 3

      Sample Output 1

      1

      By choosing edges 1,3, the shortest distance from vertex 1 to vertex 3 becomes 1. There is no way to make the shortest distance 2 or greater, so the answer is 1.

      Sample Input 2

      4 4 3
      1 2
      1 3
      3 2
      2 4

      Sample Output 2

      2

      By choosing edges 1,2,4, the shortest distance from vertex 1 to vertex 4 becomes 2. There is no way to make the shortest distance 3 or greater, so the answer is 2.

      Sample Input 3

      2 2 1
      1 2
      1 2

      Sample Output 3

      0

      Note that there may be multi-edges.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 3 2\n1 2\n2 3\n1 3",
              "1"
          ],
          [
              "4 4 3\n1 2\n1 3\n3 2\n2 4",
              "2"
          ],
          [
              "2 2 1\n1 2\n1 2",
              "0"
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
