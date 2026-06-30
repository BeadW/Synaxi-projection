Feature: LiveCodeBench/atcoder/medium — Even Digits
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      A non-negative integer n is called a good integer when it satisfies the following condition:

      - All digits in the decimal notation of n are even numbers (0, 2, 4, 6, and 8).

      For example, 0, 68, and 2024 are good integers.
      You are given an integer N. Find the N-th smallest good integer.

      Input

      The input is given from Standard Input in the following format:
      N

      Output

      Print the N-th smallest good integer.

      Constraints


      - 1 \leq N \leq 10^{12}
      - N is an integer.

      Sample Input 1

      8

      Sample Output 1

      24

      The good integers in ascending order are 0, 2, 4, 6, 8, 20, 22, 24, 26, 28, \dots.
      The eighth smallest is 24, which should be printed.

      Sample Input 2

      133

      Sample Output 2

      2024

      Sample Input 3

      31415926535

      Sample Output 3

      2006628868244228

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "8\n",
              "24\n"
          ],
          [
              "133\n",
              "2024\n"
          ],
          [
              "31415926535\n",
              "2006628868244228\n"
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
              assert r.stdout.strip() == str(expected).strip(), (
                  f"Case {i}: expected {expected!r}, got {r.stdout!r}"
              )

      """

  Scenario: Agent solves the LiveCodeBench problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py to read from stdin and write the correct answer to stdout so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
