Feature: LiveCodeBench/atcoder/hard — +1 and
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an integer sequence A = (A_1, A_2, \dots, A_N) of length N.
      You can perform the following operation any number of times, possibly zero:

      - Choose an integer pair (i, j) satisfying 1 \leq i \lt j \leq N, and replace A_i with A_i + 1 and A_j with A_j - 1.

      Determine whether it is possible to make A a non-decreasing sequence through the operations.
      You are given T test cases. Solve each of them.

      Input

      The input is given from Standard Input in the following format. Here, \mathrm{case}_i denotes the i-th test case.
      T
      \mathrm{case}_1
      \mathrm{case}_2
      \vdots
      \mathrm{case}_T

      Each test case is given in the following format:
      N
      A_1 A_2 \dots A_N

      Output

      Print T lines. The i-th line should contain the answer for the i-th test case.
      For each test case, if it is possible to make A a non-decreasing sequence through the operations, print Yes; otherwise, print No.

      Constraints


      - 1 \leq T \leq 2 \times 10^5
      - 2 \leq N \leq 2 \times 10^5
      - 0 \leq A_i \leq 10^9
      - The sum of N over all test cases is at most 2 \times 10^5.
      - All input values are integers.

      Sample Input 1

      3
      3
      1 7 5
      2
      9 0
      10
      607 495 419 894 610 636 465 331 925 724

      Sample Output 1

      Yes
      No
      Yes

      In the first test case, you can make A into a non-decreasing sequence by performing the following operations:

      - Choose (i, j) = (1, 2). After the operation, A is (2, 6, 5).
      - Choose (i, j) = (1, 2). After the operation, A is (3, 5, 5).

      In the second test case, you cannot make A into a non-decreasing sequence no matter how you perform the operations.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n3\n1 7 5\n2\n9 0\n10\n607 495 419 894 610 636 465 331 925 724",
              "Yes\nNo\nYes"
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
