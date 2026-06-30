Feature: LiveCodeBench/atcoder/hard — Diagonal Separation
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is an N \times N grid. Takahashi wants to color each cell black or white so that all of the following conditions are satisfied:

      - For every row, the following condition holds:

      - There exists an integer i\ (0\leq i\leq N) such that the leftmost i cells are colored black, and the rest are colored white.

      - For every column, the following condition holds:

      - There exists an integer i\ (0\leq i\leq N) such that the topmost i cells are colored black, and the rest are colored white.


      Out of these N^2 cells, M of them have already been colored. Among them, the i-th one is at the X_i-th row from the top and the Y_i-th column from the left, and it is colored black if C_i is B and white if C_i is W.
      Determine whether he can color the remaining uncolored N^2 - M cells so that all the conditions are satisfied.

      Input

      The input is given from Standard Input in the following format:
      N M
      X_1 Y_1 C_1
      \vdots
      X_M Y_M C_M

      Output

      If it is possible to satisfy the conditions, print Yes; otherwise, print No.

      Constraints


      - 1\leq N\leq 10^9
      - 1\leq M\leq \min(N^2,2\times 10^5)
      - 1\leq X_i,Y_i\leq N
      - (X_i,Y_i)\neq (X_j,Y_j)\ (i\neq j)
      - C_i is B or W.
      - All input numbers are integers.

      Sample Input 1

      4 3
      4 1 B
      3 2 W
      1 3 B

      Sample Output 1

      Yes

      For example, one can color the grid as in the following figure to satisfy the conditions. The cells already colored are surrounded by red borders.

      Sample Input 2

      2 2
      1 2 W
      2 2 B

      Sample Output 2

      No

      No matter how the remaining two cells are colored, the conditions cannot be satisfied.

      Sample Input 3

      1 1
      1 1 W

      Sample Output 3

      Yes

      Sample Input 4

      2289 10
      1700 1083 W
      528 967 B
      1789 211 W
      518 1708 W
      1036 779 B
      136 657 B
      759 1497 B
      902 1309 B
      1814 712 B
      936 763 B

      Sample Output 4

      No

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "4 3\n4 1 B\n3 2 W\n1 3 B",
              "Yes"
          ],
          [
              "2 2\n1 2 W\n2 2 B",
              "No"
          ],
          [
              "1 1\n1 1 W",
              "Yes"
          ],
          [
              "2289 10\n1700 1083 W\n528 967 B\n1789 211 W\n518 1708 W\n1036 779 B\n136 657 B\n759 1497 B\n902 1309 B\n1814 712 B\n936 763 B",
              "No"
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
