Feature: LiveCodeBench/atcoder/hard — Tile Distance 3
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Tiles are laid out covering the two-dimensional coordinate plane.
      Each tile is a rectangle, and for each integer triple (i, j, k) satisfying 0 \leq k < K, a corresponding tile is placed according to the following rules:

      - When i and j have the same parity (both even or both odd), the tile corresponding to (i, j, k) covers the area where iK \leq x \leq (i + 1)K and jK + k \leq y \leq jK + k + 1.
      - When i and j have different parity, the tile corresponding to (i, j, k) covers the area where iK + k \leq x \leq iK + k + 1 and jK \leq y \leq (j + 1)K.

      Two tiles are adjacent when their edges have a common segment of positive length.
      Starting from the tile containing the point (S_x + 0.5, S_y + 0.5), find the minimum number of times you need to move to an adjacent tile to reach the tile containing the point (T_x + 0.5, T_y + 0.5).
      There are T test cases; solve each of them.

      Input

      The input is given from Standard Input in the following format:
      T
      \text{case}_1
      \vdots
      \text{case}_T

      Each case is given in the following format:
      K S_x S_y T_x T_y

      Output

      Print T lines. The i-th line should contain the answer for the i-th test case.

      Constraints


      - 1 \leq T \leq 10^4
      - 2 \leq K \leq 10^{16}
      - -10^{16} \leq S_x, S_y, T_x, T_y \leq 10^{16}
      - All input values are integers.

      Sample Input 1

      3
      3 -2 1 4 -1
      4 8 8 0 2
      5 -1000000000000 -1000000000000 1000000000000 1000000000000

      Sample Output 1

      4
      4
      800000000000

      Let us explain the first test case.
      Let (i, j, k) denote the tile corresponding to integer triple (i, j, k).
      (-1.5, 1.5) is contained in tile (-1, 0, 1), and (4.5, -0.5) is contained in tile (1, -1, 2).
      For example, by moving from tile (-1, 0, 1) to (-1, 0, 2) to (0, 0, 2) to (1, 0, 0) to (1, -1, 2), you can reach tile (1, -1, 2) in four moves to an adjacent tile.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n3 -2 1 4 -1\n4 8 8 0 2\n5 -1000000000000 -1000000000000 1000000000000 1000000000000",
              "4\n4\n800000000000"
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
