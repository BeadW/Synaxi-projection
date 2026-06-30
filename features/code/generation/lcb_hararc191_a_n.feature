Feature: LiveCodeBench/atcoder/hard — A^n
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a positive integer N between 1 and 10^9, inclusive.
      Find one pair of positive integers (A, M) satisfying the following conditions. It can be proved that such a pair of integers always exists under the constraints.

      - Both A and M are positive integers between 1 and 10^{18}, inclusive.
      - There exists a positive integer n such that A^n - 1 is a multiple of M, and the smallest such n is N.

      You are given T test cases; solve each of them.

      Input

      The input is given from Standard Input in the following format:
      T
      \text{case}_1
      \text{case}_2
      \vdots
      \text{case}_T

      Here, \text{case}_i denotes the i-th test case.
      Each test case is given in the following format:
      N

      Output

      For each test case, print a pair of positive integers (A, M) in the following format:
      A M

      If there are multiple valid solutions, any one of them is considered correct.

      Constraints


      - 1 \le T \le 10^4
      - 1 \le N \le 10^9
      - All input values are integers.

      Sample Input 1

      4
      3
      16
      1
      55

      Sample Output 1

      2 7
      11 68
      20250126 1
      33 662

      Consider \text{case}_1.
      For example, if we choose (A,M)=(2,7), then:

      - When n=1: 2^1 - 1 = 1 is not a multiple of 7.
      - When n=2: 2^2 - 1 = 3 is not a multiple of 7.
      - When n=3: 2^3 - 1 = 7 is a multiple of 7.

      Hence, the smallest n for which A^n - 1 is a multiple of M is 3. Therefore, (A,M)=(2,7) is a correct solution. Other valid solutions include (A,M)=(100,777).

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "4\n3\n16\n1\n55",
              "2 7\n11 68\n20250126 1\n33 662"
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
