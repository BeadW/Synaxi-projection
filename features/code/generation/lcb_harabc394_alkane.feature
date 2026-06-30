Feature: LiveCodeBench/atcoder/hard — Alkane
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an undirected tree T with N vertices, numbered 1, 2, \ldots, N. The i-th edge is an undirected edge connecting vertices A_i and B_i.
      A graph is defined to be an alkane if and only if it satisfies the following conditions:

      - The graph is an undirected tree.
      - Every vertex has degree 1 or 4, and there is at least one vertex of degree 4.

      Determine whether there exists a subgraph of T that is an alkane, and if so, find the maximum number of vertices in such a subgraph.

      Input

      The input is given from Standard Input in the following format:
      N
      A_1 B_1
      A_2 B_2
      \vdots
      A_{N - 1} B_{N - 1}

      Output

      If there exists a subgraph of T that is an alkane, print the maximum number of vertices in such a subgraph. Otherwise, print -1.

      Constraints


      - 1 \leq N \leq 2 \times 10^5
      - 1 \leq A_i, B_i \leq N
      - The given graph is an undirected tree.
      - All input values are integers.

      Sample Input 1

      9
      1 2
      2 3
      3 4
      4 5
      2 6
      2 7
      3 8
      3 9

      Sample Output 1

      8

      Let (u, v) denote an undirected edge between vertices u and v.
      A subgraph consisting of vertices 1,2,3,4,6,7,8,9 and edges (1,2),(2,3),(3,4),(2,6),(2,7),(3,8),(3,9) is an alkane.

      Sample Input 2

      7
      1 2
      1 3
      2 4
      2 5
      3 6
      3 7

      Sample Output 2

      -1

      Sample Input 3

      15
      8 5
      2 9
      1 12
      6 11
      9 3
      15 1
      7 12
      7 13
      10 5
      6 9
      5 1
      1 9
      4 5
      6 14

      Sample Output 3

      11

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "9\n1 2\n2 3\n3 4\n4 5\n2 6\n2 7\n3 8\n3 9",
              "8"
          ],
          [
              "7\n1 2\n1 3\n2 4\n2 5\n3 6\n3 7",
              "-1"
          ],
          [
              "15\n8 5\n2 9\n1 12\n6 11\n9 3\n15 1\n7 12\n7 13\n10 5\n6 9\n5 1\n1 9\n4 5\n6 14",
              "11"
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
