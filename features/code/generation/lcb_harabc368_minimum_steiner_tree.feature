Feature: LiveCodeBench/atcoder/hard — Minimum Steiner Tree
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a tree with N vertices numbered 1 to N. The i-th edge connects vertices A_i and B_i.
      Consider a tree that can be obtained by removing some (possibly zero) edges and vertices from this graph. Find the minimum number of vertices in such a tree that includes all of K specified vertices V_1,\ldots,V_K.

      Input

      The input is given from Standard Input in the following format:
      N K
      A_1 B_1
      \vdots
      A_{N-1} B_{N-1}
      V_1 \ldots V_K

      Output

      Print the answer.

      Constraints


      - 1 \leq K \leq N \leq 2\times 10^5
      - 1 \leq A_i,B_i \leq N
      - 1 \leq V_1 < V_2 < \ldots < V_K \leq N
      - The given graph is a tree.
      - All input values are integers.

      Sample Input 1

      7 3
      1 2
      1 3
      2 4
      2 5
      3 6
      3 7
      1 3 5

      Sample Output 1

      4

      The given tree is shown on the left in the figure below. The tree with the minimum number of vertices that includes all of vertices 1,3,5 is shown on the right.

      Sample Input 2

      4 4
      3 1
      1 4
      2 1
      1 2 3 4

      Sample Output 2

      4

      Sample Input 3

      5 1
      1 4
      2 3
      5 2
      1 2
      1

      Sample Output 3

      1

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "7 3\n1 2\n1 3\n2 4\n2 5\n3 6\n3 7\n1 3 5\n",
              "4\n"
          ],
          [
              "4 4\n3 1\n1 4\n2 1\n1 2 3 4\n",
              "4\n"
          ],
          [
              "5 1\n1 4\n2 3\n5 2\n1 2\n1\n",
              "1\n"
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
