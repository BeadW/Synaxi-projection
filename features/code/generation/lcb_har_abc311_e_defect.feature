Feature: LiveCodeBench/atcoder/hard — Defect
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a grid with H rows and W columns. Let (i, j) denote the square at the i-th row from the top and j-th column from the left of the grid.
      Each square of the grid is holed or not. There are exactly N holed squares: (a_1, b_1), (a_2, b_2), \dots, (a_N, b_N).
      When the triple of positive integers (i, j, n) satisfies the following condition, the square region whose top-left corner is (i, j) and whose bottom-right corner is (i + n - 1, j + n - 1) is called a holeless square.

      - i + n - 1 \leq H.
      - j + n - 1 \leq W.
      - For every pair of non-negative integers (k, l) such that 0 \leq k \leq n - 1, 0 \leq l \leq n - 1, square (i + k, j + l) is not holed.

      How many holeless squares are in the grid?

      Input

      The input is given from Standard Input in the following format:
      H W N
      a_1 b_1
      a_2 b_2
      \vdots
      a_N b_N

      Output

      Print the number of holeless squares.

      Constraints


      - 1 \leq H, W \leq 3000
      - 0 \leq N \leq \min(H \times W, 10^5)
      - 1 \leq a_i \leq H
      - 1 \leq b_i \leq W
      - All (a_i, b_i) are pairwise different.
      - All input values are integers.

      Sample Input 1

      2 3 1
      2 3

      Sample Output 1

      6

      There are six holeless squares, listed below. For the first five, n = 1, and the top-left and bottom-right corners are the same square.

      - The square region whose top-left and bottom-right corners are (1, 1).
      - The square region whose top-left and bottom-right corners are (1, 2).
      - The square region whose top-left and bottom-right corners are (1, 3).
      - The square region whose top-left and bottom-right corners are (2, 1).
      - The square region whose top-left and bottom-right corners are (2, 2).
      - The square region whose top-left corner is (1, 1) and whose bottom-right corner is (2, 2).

      Sample Input 2

      3 2 6
      1 1
      1 2
      2 1
      2 2
      3 1
      3 2

      Sample Output 2

      0

      There may be no holeless square.

      Sample Input 3

      1 1 0

      Sample Output 3

      1

      The whole grid may be a holeless square.

      Sample Input 4

      3000 3000 0

      Sample Output 4

      9004500500

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "2 3 1\n2 3\n",
              "6\n"
          ],
          [
              "3 2 6\n1 1\n1 2\n2 1\n2 2\n3 1\n3 2\n",
              "0\n"
          ],
          [
              "1 1 0\n",
              "1\n"
          ],
          [
              "3000 3000 0\n",
              "9004500500\n"
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
              assert r.stdout.strip() == str(expected).strip(), (
                  f"Case {i}: expected {expected!r}, got {r.stdout!r}"
              )

      """

  Scenario: Agent solves the LiveCodeBench problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py to read from stdin and write the correct answer to stdout so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
