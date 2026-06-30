Feature: LiveCodeBench/atcoder/hard — Min of Restricted Sum
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given integers N, M and three integer sequences of length M: X = (X_1, X_2, \ldots, X_M), Y = (Y_1, Y_2, \ldots, Y_M), and Z = (Z_1, Z_2, \ldots, Z_M). It is guaranteed that all elements of X and Y are between 1 and N, inclusive.
      We call a length-N sequence of non-negative integers A = (A_1, A_2, \ldots, A_N) a good sequence if and only if it satisfies the following condition:

      - For every integer i with 1 \le i \le M, the XOR of A_{X_i} and A_{Y_i} is Z_i.

      Determine whether a good sequence A=(A_1,A_2,\ldots,A_N) exists, and if it exists, find one good sequence that minimizes the sum of its elements \displaystyle \sum_{i=1}^N A_i.

      Notes on XOR

      For non-negative integers A and B, their XOR A \oplus B is defined as follows:


      - In the binary representation of A \oplus B, the digit in the place corresponding to 2^k \,(k \ge 0) is 1 if and only if exactly one of the digits in the same place of A and B is 1; otherwise, it is 0.


      For example, 3 \oplus 5 = 6 (in binary: 011 \oplus 101 = 110).

      Input

      The input is given from Standard Input in the following format:
      N M
      X_1 Y_1 Z_1
      X_2 Y_2 Z_2
      \vdots
      X_M Y_M Z_M

      Output

      If no good sequence exists, print -1.
      If a good sequence exists, print one good sequence that minimizes the sum of its elements, separated by spaces.
      If there are multiple good sequences with the same minimum sum, printing any of them is accepted.

      Constraints


      - 1 \le N \le 2\times 10^5
      - 0 \le M \le 10^5
      - 1 \le X_i, Y_i \le N
      - 0 \le Z_i \le 10^9
      - All input values are integers.

      Sample Input 1

      3 2
      1 3 4
      1 2 3

      Sample Output 1

      0 3 4

      A=(0,3,4) is a good sequence because A_1 \oplus A_2 = 3 and A_1 \oplus A_3 = 4.
      Other good sequences include A=(1,2,5) and A=(7,4,3), but A=(0,3,4) has the smallest sum among all good sequences.

      Sample Input 2

      3 3
      1 3 4
      1 2 3
      2 3 5

      Sample Output 2

      -1

      No good sequence exists, so print -1.

      Sample Input 3

      5 8
      4 2 4
      2 3 11
      3 4 15
      4 5 6
      3 2 11
      3 3 0
      3 1 9
      3 4 15

      Sample Output 3

      0 2 9 6 0

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 2\n1 3 4\n1 2 3",
              "0 3 4"
          ],
          [
              "3 3\n1 3 4\n1 2 3\n2 3 5",
              "-1"
          ],
          [
              "5 8\n4 2 4\n2 3 11\n3 4 15\n4 5 6\n3 2 11\n3 3 0\n3 1 9\n3 4 15",
              "0 2 9 6 0"
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
