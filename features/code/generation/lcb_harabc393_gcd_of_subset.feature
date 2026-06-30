Feature: LiveCodeBench/atcoder/hard — GCD of Subset
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a sequence A = (A_1, A_2, \dots, A_N) of length N and a positive integer K (at most N).
      For each i = 1, 2, \dots, N, solve the following problem:

      - When you choose K elements from A that include A_i, find the maximum possible GCD (greatest common divisor) of those chosen elements.

      Input

      The input is given from Standard Input in the following format:
      N K
      A_1 A_2 \dots A_N

      Output

      Print N lines. The j-th line should contain the answer for i=j.

      Constraints


      - 1 \leq K \leq N \leq 1.2 \times 10^6
      - 1 \leq A_i \leq 10^6
      - All input values are integers.

      Sample Input 1

      5 2
      3 4 6 7 12

      Sample Output 1

      3
      4
      6
      1
      6

      For i=1, choosing A_1 and A_3 yields \gcd(\lbrace 3,6 \rbrace) = 3, which is the maximum.
      For i=2, choosing A_2 and A_5 yields \gcd(\lbrace 4,12 \rbrace) = 4, which is the maximum.
      For i=3, choosing A_3 and A_5 yields \gcd(\lbrace 6,12 \rbrace) = 6, which is the maximum.
      For i=4, choosing A_4 and A_2 yields \gcd(\lbrace 7,4 \rbrace) = 1, which is the maximum.
      For i=5, choosing A_5 and A_3 yields \gcd(\lbrace 12,6 \rbrace) = 6, which is the maximum.

      Sample Input 2

      3 3
      6 10 15

      Sample Output 2

      1
      1
      1

      Sample Input 3

      10 3
      414003 854320 485570 52740 833292 625990 909680 885153 435420 221663

      Sample Output 3

      59
      590
      590
      879
      879
      590
      20
      879
      590
      59

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5 2\n3 4 6 7 12",
              "3\n4\n6\n1\n6"
          ],
          [
              "3 3\n6 10 15",
              "1\n1\n1"
          ],
          [
              "10 3\n414003 854320 485570 52740 833292 625990 909680 885153 435420 221663",
              "59\n590\n590\n879\n879\n590\n20\n879\n590\n59"
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
