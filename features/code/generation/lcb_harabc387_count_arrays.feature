Feature: LiveCodeBench/atcoder/hard — Count Arrays
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given positive integers N, M, and a sequence A = (A_1, A_2, \dots, A_N) of length N, each element being an integer between 1 and N, inclusive.
      Find the number, modulo 998244353, of sequences x = (x_1, x_2, \dots, x_N) of length N, each element being an integer between 1 and M, inclusive, that satisfy the following condition:

      - x_i \leq x_{A_i} for every i (1 \leq i \leq N).

      Input

      The input is given from Standard Input in the following format:
      N M
      A_1 A_2 \dots A_N

      Output

      Print the answer.

      Constraints


      - 1 \leq N, M \leq 2025
      - 1 \leq A_i \leq N
      - All input values are integers.

      Sample Input 1

      3 3
      2 1 1

      Sample Output 1

      6

      The sequences x=(1,1,1),(2,2,1),(2,2,2),(3,3,1),(3,3,2),(3,3,3) satisfy the condition.

      Sample Input 2

      4 9
      1 1 1 1

      Sample Output 2

      2025

      Sample Input 3

      10 5
      9 4 5 5 4 2 1 5 7 2

      Sample Output 3

      10010

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 3\n2 1 1",
              "6"
          ],
          [
              "4 9\n1 1 1 1",
              "2025"
          ],
          [
              "10 5\n9 4 5 5 4 2 1 5 7 2",
              "10010"
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
