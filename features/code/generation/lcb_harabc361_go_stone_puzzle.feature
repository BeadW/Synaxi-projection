Feature: LiveCodeBench/atcoder/hard — Go Stone Puzzle
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There are N+2 cells arranged in a row. Let cell i denote the i-th cell from the left.
      There is one stone placed in each of the cells from cell 1 to cell N.
      For each 1 \leq i \leq N, the stone in cell i is white if S_i is W, and black if S_i is B.
      Cells N+1 and N+2 are empty.
      You can perform the following operation any number of times (possibly zero):

      - Choose a pair of adjacent cells that both contain stones, and move these two stones to the empty two cells while preserving their order.
        More precisely, choose an integer x such that 1 \leq x \leq N+1 and both cells x and x+1 contain stones. Let k and k+1 be the empty two cells. Move the stones from cells x and x+1 to cells k and k+1, respectively.

      Determine if it is possible to achieve the following state, and if so, find the minimum number of operations required:

      - Each of the cells from cell 1 to cell N contains one stone, and for each 1 \leq i \leq N, the stone in cell i is white if T_i is W, and black if T_i is B.

      Input

      The input is given from Standard Input in the following format:
      N
      S
      T

      Output

      If it is possible to achieve the desired state, print the minimum number of operations required. If it is impossible, print -1.

      Constraints


      - 2 \leq N \leq 14
      - N is an integer.
      - Each of S and T is a string of length N consisting of B and W.

      Sample Input 1

      6
      BWBWBW
      WWWBBB

      Sample Output 1

      4

      Using . to represent an empty cell, the desired state can be achieved in four operations as follows, which is the minimum:

      - BWBWBW..
      - BW..BWBW
      - BWWBB..W
      - ..WBBBWW
      - WWWBBB..

      Sample Input 2

      6
      BBBBBB
      WWWWWW

      Sample Output 2

      -1

      Sample Input 3

      14
      BBBWBWWWBBWWBW
      WBWWBBWWWBWBBB

      Sample Output 3

      7

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "6\nBWBWBW\nWWWBBB\n",
              "4\n"
          ],
          [
              "6\nBBBBBB\nWWWWWW\n",
              "-1\n"
          ],
          [
              "14\nBBBWBWWWBBWWBW\nWBWWBBWWWBWBBB\n",
              "7\n"
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
