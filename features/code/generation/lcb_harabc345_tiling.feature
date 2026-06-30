Feature: LiveCodeBench/atcoder/hard — Tiling
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a grid of H rows and W columns, each cell having a side length of 1, and we have N tiles.
      The i-th tile (1\leq i\leq N) is a rectangle of size A_i\times B_i.
      Determine whether it is possible to place the tiles on the grid so that all of the following conditions are satisfied:

      - Every cell is covered by exactly one tile.
      - It is fine to have unused tiles.
      - The tiles may be rotated or flipped when placed. However, each tile must be aligned with the edges of the cells without extending outside the grid.

      Input

      The input is given from Standard Input in the following format:
      N H W
      A_1 B_1
      A_2 B_2
      \ldots
      A_N B_N

      Output

      If it is possible to place the tiles on the grid so that all of the conditions in the problem statement are satisfied, print Yes; otherwise, print No.

      Constraints


      - 1\leq N\leq 7
      - 1 \leq H,W \leq 10
      - 1\leq A_i,B_i\leq 10
      - All input values are integers.

      Sample Input 1

      5 5 5
      1 1
      3 3
      4 4
      2 3
      2 5

      Sample Output 1

      Yes

      Placing the 2-nd, 4-th, and 5-th tiles as shown below covers every cell of the grid by exactly one tile.

      Hence, print Yes.

      Sample Input 2

      1 1 2
      2 3

      Sample Output 2

      No

      It is impossible to place the tile without letting it extend outside the grid.
      Hence, print No.

      Sample Input 3

      1 2 2
      1 1

      Sample Output 3

      No

      It is impossible to cover all cells with the tile.
      Hence, print No.

      Sample Input 4

      5 3 3
      1 1
      2 2
      2 2
      2 2
      2 2

      Sample Output 4

      No

      Note that each cell must be covered by exactly one tile.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5 5 5\n1 1\n3 3\n4 4\n2 3\n2 5\n",
              "Yes\n"
          ],
          [
              "1 1 2\n2 3\n",
              "No\n"
          ],
          [
              "1 2 2\n1 1\n",
              "No\n"
          ],
          [
              "5 3 3\n1 1\n2 2\n2 2\n2 2\n2 2\n",
              "No\n"
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
