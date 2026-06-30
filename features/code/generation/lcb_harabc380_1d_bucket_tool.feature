Feature: LiveCodeBench/atcoder/hard — 1D Bucket Tool
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There are N cells in a row, numbered 1 to N.
      For each 1 \leq i < N, cells i and i+1 are adjacent.
      Initially, cell i is painted with color i.
      You are given Q queries. Process them in order. Each query is of one of the following two types.

      - 1 x c: Repaint the following to color c: all reachable cells reachable from cell x by repeatedly moving to an adjacent cell painted in the same color as the current cell.
      - 2 c: Print the number of cells painted with color c.

      Input

      The input is given from Standard Input in the following format:
      N Q
      \mathrm{query}_1
      \vdots
      \mathrm{query}_Q

      Each query is given in one of the following two formats:
      1 x c

      2 c

      Output

      Let q be the number of queries of the second type. Print q lines.
      The i-th line should contain the answer to the i-th such query.

      Constraints


      - 1 \leq N \leq 5 \times 10^5
      - 1 \leq Q \leq 2 \times 10^5
      - In queries of the first type, 1 \leq x \leq N.
      - In queries of the first and second types, 1 \leq c \leq N.
      - There is at least one query of the second type.
      - All input values are integers.

      Sample Input 1

      5 6
      1 5 4
      1 4 2
      2 2
      1 3 2
      1 2 3
      2 3

      Sample Output 1

      3
      4

      The queries recolor the cells as shown in the figure.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5 6\n1 5 4\n1 4 2\n2 2\n1 3 2\n1 2 3\n2 3",
              "3\n4"
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
