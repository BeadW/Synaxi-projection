Feature: LiveCodeBench/atcoder/hard — Minimum Cost Sort
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a permutation P = (P_1, P_2, \ldots, P_N) of (1, 2, \ldots, N). Takahashi can repeatedly perform the following operation on P (possibly zero times):

      - Choose an integer i satisfying 1 \leq i \leq N-1. Pay a cost of i, and swap P_i and P_{i+1}.

      Find the minimum total cost required to sort P in ascending order.

      Input

      The input is given from Standard Input in the following format:
      N
      P_1 P_2 \ldots P_N

      Output

      Print the minimum total cost required to sort P in ascending order.

      Constraints


      - 2 \leq N \leq 2 \times 10^5
      - (P_1, P_2, \ldots, P_N) is a permutation of (1, 2, \ldots, N).
      - All input values are integers.

      Sample Input 1

      3
      3 2 1

      Sample Output 1

      4

      Takahashi can sort P in ascending order as follows:

      - Pay a cost of 1 and swap P_1 = 3 and P_2 = 2. Now, P = (2, 3, 1).
      - Pay a cost of 2 and swap P_2 = 3 and P_3 = 1. Now, P = (2, 1, 3).
      - Pay a cost of 1 and swap P_1 = 2 and P_2 = 1. Now, P = (1, 2, 3).

      The total cost for these operations is 4, which is the minimum possible.

      Sample Input 2

      5
      2 4 1 3 5

      Sample Output 2

      6

      Sample Input 3

      2
      1 2

      Sample Output 3

      0

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n3 2 1",
              "4"
          ],
          [
              "5\n2 4 1 3 5",
              "6"
          ],
          [
              "2\n1 2",
              "0"
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
