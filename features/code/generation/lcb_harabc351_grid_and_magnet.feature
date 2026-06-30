Feature: LiveCodeBench/atcoder/hard — Grid and Magnet
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a grid of H rows and W columns. Some cells (possibly zero) contain magnets.
      The state of the grid is represented by H strings S_1, S_2, \ldots, S_H of length W. If the j-th character of S_i is #, it indicates that there is a magnet in the cell at the i-th row from the top and j-th column from the left; if it is ., it indicates that the cell is empty.
      Takahashi, wearing an iron armor, can move in the grid as follows:

      - If any of the cells vertically or horizontally adjacent to the current cell contains a magnet, he cannot move at all.
      - Otherwise, he can move to any one of the vertically or horizontally adjacent cells.
      However, he cannot exit the grid.

      For each cell without a magnet, define its degree of freedom as the number of cells he can reach by repeatedly moving from that cell. Find the maximum degree of freedom among all cells without magnets in the grid.
      Here, in the definition of degree of freedom, "cells he can reach by repeatedly moving" mean cells that can be reached from the initial cell by some sequence of moves (possibly zero moves). It is not necessary that there is a sequence of moves that visits all such reachable cells starting from the initial cell. Specifically, each cell itself (without a magnet) is always included in the cells reachable from that cell.

      Input

      The input is given from Standard Input in the following format:
      H W
      S_1
      S_2
      \vdots
      S_H

      Output

      Print the maximum degree of freedom among all cells without magnets.

      Constraints


      - 1 \leq H, W \leq 1000
      - H and W are integers.
      - S_i is a string of length W consisting of . and #.
      - There is at least one cell without a magnet.

      Sample Input 1

      3 5
      .#...
      .....
      .#..#

      Sample Output 1

      9

      Let (i,j) denote the cell at the i-th row from the top and j-th column from the left. If Takahashi starts at (2,3), possible movements include:

      - (2,3) \to (2,4) \to (1,4) \to (1,5) \to (2,5)
      - (2,3) \to (2,4) \to (3,4)
      - (2,3) \to (2,2)
      - (2,3) \to (1,3)
      - (2,3) \to (3,3)

      Thus, including the ce

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 5\n.#...\n.....\n.#..#\n",
              "9\n"
          ],
          [
              "3 3\n..#\n#..\n..#\n",
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
