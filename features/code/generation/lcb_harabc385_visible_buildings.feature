Feature: LiveCodeBench/atcoder/hard — Visible Buildings
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There are N buildings numbered 1 to N on a number line.
      Building i is at coordinate X_i and has height H_i. The size in directions other than height is negligible.
      From a point P with coordinate x and height h, building i is considered visible if there exists a point Q on building i such that the line segment PQ does not intersect with any other building.
      Find the maximum height at coordinate 0 from which it is not possible to see all buildings. Height must be non-negative; if it is possible to see all buildings at height 0 at coordinate 0, report -1 instead.

      Input

      The input is given from Standard Input in the following format:
      N
      X_1 H_1
      \vdots
      X_N H_N

      Output

      If it is possible to see all buildings from coordinate 0 and height 0, print -1. Otherwise, print the maximum height at coordinate 0 from which it is not possible to see all buildings. Answers with an absolute or relative error of at most 10^{-9} from the true answer will be considered correct.

      Constraints


      - 1 \leq N \leq 2 \times 10^5
      - 1 \leq X_1 < \dots < X_N \leq 10^9
      - 1 \leq H_i \leq 10^9
      - All input values are integers.

      Sample Input 1

      3
      3 2
      5 4
      7 5

      Sample Output 1

      1.500000000000000000

      From coordinate 0 and height 1.5, building 3 cannot be seen. If the height is even slightly greater than 1.5, all buildings including building 3 can be seen. Thus, the answer is 1.5.

      Sample Input 2

      2
      1 1
      2 100

      Sample Output 2

      -1

      Note that -1.000 or similar outputs would be considered incorrect.

      Sample Input 3

      3
      1 1
      2 2
      3 3

      Sample Output 3

      0.000000000000000000

      Sample Input 4

      4
      10 10
      17 5
      20 100
      27 270

      Sample Output 4

      17.142857142857142350

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n3 2\n5 4\n7 5",
              "1.500000000000000000"
          ],
          [
              "2\n1 1\n2 100",
              "-1"
          ],
          [
              "3\n1 1\n2 2\n3 3",
              "0.000000000000000000"
          ],
          [
              "4\n10 10\n17 5\n20 100\n27 270",
              "17.142857142857142350"
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
