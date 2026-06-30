Feature: LiveCodeBench/atcoder/hard — Add One Edge 2
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a tree with N vertices. The i-th edge (1 \leq i \leq N-1) connects vertices u_i and v_i bidirectionally.
      Adding one undirected edge to the given tree always yields a graph with exactly one cycle.
      Among such graphs, how many satisfy all of the following conditions?

      - The graph is simple.
      - All vertices in the cycle have degree 3.

      Input

      The input is given from Standard Input in the following format:
      N
      u_1 v_1
      u_2 v_2
      \vdots
      u_{N-1} v_{N-1}

      Output

      Print the answer.

      Constraints


      - 3 \leq N \leq 2 \times 10^5
      - 1 \leq u_i, v_i \leq N
      - The given graph is a tree.
      - All input values are integers.

      Sample Input 1

      6
      1 2
      2 3
      3 4
      4 5
      3 6

      Sample Output 1

      1

      Adding an edge connecting vertices 2 and 4 yields a simple graph where all vertices in the cycle have degree 3, so it satisfies the conditions.

      Sample Input 2

      7
      1 2
      2 7
      3 5
      7 3
      6 2
      4 7

      Sample Output 2

      0

      There are cases where no graphs satisfy the conditions.

      Sample Input 3

      15
      1 15
      11 14
      2 10
      1 7
      9 8
      6 9
      4 12
      14 5
      4 9
      8 11
      7 4
      1 13
      3 6
      11 10

      Sample Output 3

      6

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "6\n1 2\n2 3\n3 4\n4 5\n3 6",
              "1"
          ],
          [
              "7\n1 2\n2 7\n3 5\n7 3\n6 2\n4 7",
              "0"
          ],
          [
              "15\n1 15\n11 14\n2 10\n1 7\n9 8\n6 9\n4 12\n14 5\n4 9\n8 11\n7 4\n1 13\n3 6\n11 10",
              "6"
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
