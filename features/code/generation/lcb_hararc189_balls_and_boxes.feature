Feature: LiveCodeBench/atcoder/hard — Balls and Boxes
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There are N boxes.
      For i = 1, 2, \ldots, N, the i-th box contains A_i red balls and B_i blue balls.
      You are also given two permutations P = (P_1, P_2, \ldots, P_N) and Q = (Q_1, Q_2, \ldots, Q_N) of (1, 2, \ldots, N).
      Takahashi can repeat the following operation any number of times, possibly zero:

      - Choose an integer 1 \leq i \leq N, and take all the balls from the i-th box into his hand.
      - Put all the red balls in his hand into the P_i-th box.
      - Put all the blue balls in his hand into the Q_i-th box.

      His goal is to make a state where all boxes other than the X-th box contain no balls by repeating the above operations.
      Determine whether it is possible to achieve his goal, and if possible, print the minimum number of operations needed to achieve it.

      Input

      The input is given from Standard Input in the following format:
      N X
      A_1 A_2 \ldots A_N
      B_1 B_2 \ldots B_N
      P_1 P_2 \ldots P_N
      Q_1 Q_2 \ldots Q_N

      Output

      If it is impossible for Takahashi to achieve a state where all boxes other than the X-th box contain no balls, print -1. If it is possible, print the minimum number of operations needed to achieve it.

      Constraints


      - 2 \leq N \leq 2 \times 10^5
      - 0 \leq A_i, B_i \leq 1
      - 1 \leq P_i, Q_i \leq N
      - P and Q are permutations of (1, 2, \ldots, N).
      - 1 \leq X \leq N
      - All input values are integers.

      Sample Input 1

      5 3
      0 1 0 1 0
      0 0 1 0 1
      4 1 2 3 5
      3 4 5 2 1

      Sample Output 1

      4

      The numbers of red and blue balls in each box are A = (0, 1, 0, 1, 0) and B = (0, 0, 1, 0, 1), respectively.
      Consider the following steps:

      - First, perform the operation on the 5th box. As a result, A = (0, 1, 0, 1, 0), B = (1, 0, 1, 0, 0).
      - Next, perform the operation on the 2nd box. As a result, A = (1, 0, 0, 1, 0), B = (1, 0, 1, 0, 0).
      - Then, perform the operation on the 1st box. As a result, A = (0, 0, 0, 2, 0), B = (0, 0, 2, 0, 0).
      - Finally, perform the operation on the 4th box. As a result, A = (0, 0, 2, 0, 0), B = (0, 0, 2, 0, 0).

      These four operations achieve a state w

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5 3\n0 1 0 1 0\n0 0 1 0 1\n4 1 2 3 5\n3 4 5 2 1",
              "4"
          ],
          [
              "5 3\n0 0 0 0 0\n0 0 0 0 0\n4 1 2 3 5\n3 4 5 2 1",
              "0"
          ],
          [
              "2 2\n1 1\n1 1\n1 2\n1 2",
              "-1"
          ],
          [
              "10 10\n0 0 0 0 0 0 1 0 1 0\n0 0 0 0 1 1 0 0 1 0\n1 4 9 5 8 2 3 6 10 7\n7 4 9 10 6 3 1 2 8 5",
              "8"
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
