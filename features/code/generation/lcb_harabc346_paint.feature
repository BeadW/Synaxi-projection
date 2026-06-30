Feature: LiveCodeBench/atcoder/hard — Paint
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a grid with H rows and W columns. Initially, all cells are painted with color 0.
      You will perform the following operations in the order i = 1, 2, \ldots, M.

      - 
      If T_i = 1, repaint all cells in the A_i-th row with color X_i.

      - 
      If T_i = 2, repaint all cells in the A_i-th column with color X_i.


      After all operations are completed, for each color i that exists on the grid, find the number of cells that are painted with color i.

      Input

      The input is given from Standard Input in the following format:
      H W M
      T_1 A_1 X_1
      T_2 A_2 X_2
      \vdots
      T_M A_M X_M

      Output

      Let K be the number of distinct integers i such that there are cells painted with color i. Print K + 1 lines.
      The first line should contain the value of K.
      The second and subsequent lines should contain, for each color i that exists on the grid, the color number i and the number of cells painted with that color.
      Specifically, the (i + 1)-th line (1 \leq i \leq K) should contain the color number c_i and the number of cells x_i painted with color c_i, in this order, separated by a space.
      Here, print the color numbers in ascending order. That is, ensure that c_1 < c_2 < \ldots < c_K. Note also that x_i > 0 is required.

      Constraints


      - 1 \leq H, W, M \leq 2 \times 10^5
      - T_i \in \lbrace 1, 2 \rbrace
      - 1 \leq A_i \leq H for each i such that T_i = 1,
      - 1 \leq A_i \leq W for each i such that T_i = 2.
      - 0 \leq X_i \leq 2 \times 10^5
      - All input values are integers.

      Sample Input 1

      3 4 4
      1 2 5
      2 4 0
      1 3 3
      1 3 2

      Sample Output 1

      3
      0 5
      2 4
      5 3

      The operations will change the colors of the cells in the grid as follows:
      0000   0000   0000   0000   0000
      0000 → 5555 → 5550 → 5550 → 5550 
      0000   0000   0000   3333   2222

      Eventually, there are five cells painted with color 0, four with color 2, and three with color 5.

      Sample Input 2

      1 1 5
      1 1 1
      1 1 10
      2 1 100
      1 1 1000
      2 1 10000

      Sample Output 2

      1
      10000 1

      Sample Input 3

      5 5 10
      1 1 1
      1 2 2
      1 3 3
      1 4 4
      1 5 5
      2 1 6
      2 2 7
      2 3 8
      2 4 9
      2 5 10

      Sample Output 3

      5
      6 5
      7 5


      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 4 4\n1 2 5\n2 4 0\n1 3 3\n1 3 2\n",
              "3\n0 5\n2 4\n5 3\n"
          ],
          [
              "1 1 5\n1 1 1\n1 1 10\n2 1 100\n1 1 1000\n2 1 10000\n",
              "1\n10000 1\n"
          ],
          [
              "5 5 10\n1 1 1\n1 2 2\n1 3 3\n1 4 4\n1 5 5\n2 1 6\n2 2 7\n2 3 8\n2 4 9\n2 5 10\n",
              "5\n6 5\n7 5\n8 5\n9 5\n10 5\n"
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
