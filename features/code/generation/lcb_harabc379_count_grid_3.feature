Feature: LiveCodeBench/atcoder/hard — Count Grid 3
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a grid S with H rows and W columns consisting of 1, 2, 3, and ?. The character at the i-th row and j-th column is S_{i,j}.
      By replacing each ? in S with 1, 2, or 3, we can obtain 3^q different grids, where q is the number of ?. Among these grids, how many satisfy the following condition? Print the count modulo 998244353.

      - Any two adjacent (edge-sharing) cells contain different digits.

      Input

      The input is given from Standard Input in the following format:
      H W
      S_{1,1}S_{1,2}\ldots S_{1,W}
      S_{2,1}S_{2,2}\ldots S_{2,W}
      \vdots
      S_{H,1}S_{H,2}\ldots S_{H,W}

      Output

      Print the answer.

      Constraints


      - 1 \leq H, W
      - H \times W \leq 200
      - H and W are integers.
      - S is a grid with H rows and W columns consisting of 1, 2, 3, and ?.

      Sample Input 1

      2 2
      1?
      ??

      Sample Output 1

      6

      Among the grids obtained by replacing each ? in S with 1, 2, or 3, the following six grids satisfy the condition.
      12  12  12  13  13  13
      21  23  31  21  31  32

      Sample Input 2

      2 3
      123
      3?1

      Sample Output 2

      0

      None of the grids obtained by replacing ? satisfies the condition.

      Sample Input 3

      8 8
      3?1?????
      ???1????
      ??????2?
      ????????
      ????????
      ????13??
      ??13?1??
      ????????

      Sample Output 3

      779135038

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "2 2\n1?\n??",
              "6"
          ],
          [
              "2 3\n123\n3?1",
              "0"
          ],
          [
              "8 8\n3?1?????\n???1????\n??????2?\n????????\n????????\n????13??\n??13?1??\n????????",
              "779135038"
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
