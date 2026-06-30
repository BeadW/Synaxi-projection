Feature: LiveCodeBench/atcoder/medium — Find snuke
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a grid with H horizontal rows and W vertical columns.  Each cell has a lowercase English letter written on it.
      We denote by (i, j) the cell at the i-th row from the top and j-th column from the left.
      The letters written on the grid are represented by H strings S_1,S_2,\ldots, S_H, each of length W.
      The j-th letter of S_i represents the letter written on (i, j).
      There is a unique set of
      contiguous cells (going vertically, horizontally, or diagonally) in the grid
      with s, n, u, k, and e written on them in this order.
      Find the positions of such cells and print them in the format specified in the Output section.
      A tuple of five cells (A_1,A_2,A_3,A_4,A_5) is said to form
      a set of contiguous cells (going vertically, horizontally, or diagonally) with s, n, u, k, and e written on them in this order
      if and only if all of the following conditions are satisfied.

      - A_1,A_2,A_3,A_4 and A_5 have letters s, n, u, k, and e written on them, respectively.
      - For all 1\leq i\leq 4, cells A_i and A_{i+1} share a corner or a side.
      - The centers of A_1,A_2,A_3,A_4, and A_5 are on a common line at regular intervals.

      Input

      The input is given from Standard Input in the following format:
      H W
      S_1
      S_2
      \vdots
      S_H

      Output

      Print five lines in the following format.  
      Let (R_1,C_1), (R_2,C_2)\ldots,(R_5,C_5) be the cells in the sought set with s, n, u, k, and e written on them, respectively.
      The i-th line should contain R_i and C_i in this order, separated by a space.
      In other words, print them in the following format:
      R_1 C_1
      R_2 C_2
      \vdots
      R_5 C_5

      See also Sample Inputs and Outputs below.

      Constraints


      - 5\leq H\leq 100
      - 5\leq W\leq 100
      - H and W are integers.
      - S_i is a string of length W consisting of lowercase English letters.
      - The given grid has a unique conforming set of cells.

      Sample Input 1

      6 6
      vgxgpu
      amkxks
      zhkbpp
      hykink
      esnuke
      zplvfj

      Sample Output 1

      5 2
      5 3
      5 4
      5 5
      5 6

      Tuple (A_1,A_2,A_3,A_4,A_5)=((5,2),(5,3),(5,4),(5,5),(5,6)) satisfies th

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "6 6\nvgxgpu\namkxks\nzhkbpp\nhykink\nesnuke\nzplvfj\n",
              "5 2\n5 3\n5 4\n5 5\n5 6\n"
          ],
          [
              "5 5\nezzzz\nzkzzz\nezuzs\nzzznz\nzzzzs\n",
              "5 5\n4 4\n3 3\n2 2\n1 1\n"
          ],
          [
              "10 10\nkseeusenuk\nusesenesnn\nkskekeeses\nnesnusnkkn\nsnenuuenke\nkukknkeuss\nneunnennue\nsknuessuku\nnksneekknk\nneeeuknenk\n",
              "9 3\n8 3\n7 3\n6 3\n5 3\n"
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
