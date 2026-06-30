Feature: LiveCodeBench/atcoder/hard — Manhattan Multifocal Ellipse
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given N points (x_1, y_1), (x_2, y_2), \dots, (x_N, y_N) on a two-dimensional plane, and a non-negative integer D.
      Find the number of integer pairs (x, y) such that \displaystyle \sum_{i=1}^N (|x-x_i|+|y-y_i|) \leq D.

      Input

      The input is given from Standard Input in the following format:
      N D
      x_1 y_1
      x_2 y_2
      \vdots
      x_N y_N

      Output

      Print the answer.

      Constraints


      - 1 \leq N \leq 2 \times 10^5
      - 0 \leq D \leq 10^6
      - -10^6 \leq x_i, y_i \leq 10^6
      - (x_i, y_i) \neq (x_j, y_j) for i \neq j.
      - All input values are integers.

      Sample Input 1

      2 3
      0 0
      1 0

      Sample Output 1

      8

      The following figure visualizes the input and the answer for Sample 1. The blue points represent the input. The blue and red points, eight in total, satisfy the condition in the statement.

      Sample Input 2

      2 0
      0 0
      2 0

      Sample Output 2

      0

      Sample Input 3

      6 100
      9 -6
      10 -1
      2 10
      -1 7
      -7 5
      -1 -4

      Sample Output 3

      419

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "2 3\n0 0\n1 0\n",
              "8\n"
          ],
          [
              "2 0\n0 0\n2 0\n",
              "0\n"
          ],
          [
              "6 100\n9 -6\n10 -1\n2 10\n-1 7\n-7 5\n-1 -4\n",
              "419\n"
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
