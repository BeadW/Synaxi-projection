Feature: LiveCodeBench/atcoder/hard — Rotated Inversions
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given integers N, M and a length-N sequence of non-negative integers A = (A_1, A_2, \ldots, A_N).
      For k = 0, 1, \ldots, M-1, solve the following problem:

      Define an integer sequence B = (B_1, B_2, \ldots, B_N) so that B_i is the remainder of A_i + k when divided by M. Find the inversion number in B.


      What is the inversion number?
      The inversion number of a sequence (A_1, A_2, \dots, A_N) is the number of integer pairs (i, j) satisfying 1 \le i < j \le N and A_i > A_j.

      Input

      The input is given from Standard Input in the following format:
      N M
      A_1 A_2 \ldots A_N

      Output

      Print M lines.
      The i-th line (1 \le i \le M) should contain the answer for the case k = i-1.

      Constraints


      - 1 \le N,M \le 2\times 10^5
      - 0 \le A_i < M
      - All input values are integers.

      Sample Input 1

      3 3
      2 1 0

      Sample Output 1

      3
      1
      1


      - For k=0: B=(2, 1, 0). The inversion number is 3.
      - For k=1: B=(0, 2, 1). The inversion number is 1.
      - For k=2: B=(1, 0, 2). The inversion number is 1.

      Sample Input 2

      5 6
      5 3 5 0 1

      Sample Output 2

      7
      3
      3
      1
      1
      5

      Sample Input 3

      7 7
      0 1 2 3 4 5 6

      Sample Output 3

      0
      6
      10
      12
      12
      10
      6

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 3\n2 1 0",
              "3\n1\n1"
          ],
          [
              "5 6\n5 3 5 0 1",
              "7\n3\n3\n1\n1\n5"
          ],
          [
              "7 7\n0 1 2 3 4 5 6",
              "0\n6\n10\n12\n12\n10\n6"
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
