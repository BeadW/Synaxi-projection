Feature: LiveCodeBench/atcoder/hard — Swap and Erase
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a sequence A = (A_1,\ldots,A_N). You can perform the following two types of operations any number of times in any order:

      - Let K be the length of A just before the operation. Choose an integer i such that 1 \leq i \leq K-1, and swap the i-th and (i+1)-th elements of A.
      - Let K be the length of A just before the operation. Choose an integer i such that 1 \leq i \leq K and all the values from the 1-st through the i-th elements of A are equal, and delete all the elements from the 1-st through the i-th of A.

      Find the minimum total number of operations required to make A an empty sequence.
      You are given T test cases; solve each of them.

      Input

      The input is given from Standard Input in the following format:
      T
      \mathrm{case}_1
      \mathrm{case}_2
      \vdots
      \mathrm{case}_T

      Each case is given in the following format:
      N
      A_1 A_2 \ldots A_N

      Output

      Print the answer for each test case in order, separated by newlines.

      Constraints


      - 1\leq T\leq 10^5
      - 2 \leq N \leq 2 \times 10^5
      - 1 \leq A_i \leq N
      - The sum of N over all test cases is at most 2\times 10^5.
      - All input values are integers.

      Sample Input 1

      3
      5
      1 1 2 1 2
      4
      4 2 1 3
      11
      1 2 1 2 1 2 1 2 1 2 1

      Sample Output 1

      3
      4
      8

      For the 1st test case, A can be made empty by the following three operations:

      - Swap the 3rd and 4th elements of A. Now, A is (1,1,1,2,2).
      - Delete the 1st through 3rd elements of A. Now, A is (2,2).
      - Delete the 1st through 2nd elements of A. Now, A is an empty sequence.

      For the 2nd test case, A can be made empty by deleting the 1st element four times. Also, it is impossible to make A empty in three or fewer operations.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n5\n1 1 2 1 2\n4\n4 2 1 3\n11\n1 2 1 2 1 2 1 2 1 2 1",
              "3\n4\n8"
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
