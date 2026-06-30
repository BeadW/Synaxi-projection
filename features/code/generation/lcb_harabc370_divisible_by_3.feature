Feature: LiveCodeBench/atcoder/hard — Divisible by 3
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      We call a positive integer n a good integer if and only if the sum of its positive divisors is divisible by 3.
      You are given two positive integers N and M. Find the number, modulo 998244353, of length-M sequences A of positive integers such that the product of the elements in A is a good integer not exceeding N.

      Input

      The input is given from Standard Input in the following format:
      N M

      Output

      Print the answer.

      Constraints


      - 1 \leq N \leq 10^{10}
      - 1 \leq M \leq 10^5
      - N and M are integers.

      Sample Input 1

      10 1

      Sample Output 1

      5

      There are five sequences that satisfy the conditions:

      - (2)
      - (5)
      - (6)
      - (8)
      - (10)

      Sample Input 2

      4 2

      Sample Output 2

      2

      There are two sequences that satisfy the conditions:

      - (1, 2)
      - (2, 1)

      Sample Input 3

      370 907

      Sample Output 3

      221764640

      Sample Input 4

      10000000000 100000

      Sample Output 4

      447456146

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "10 1\n",
              "5\n"
          ],
          [
              "4 2\n",
              "2\n"
          ],
          [
              "370 907\n",
              "221764640\n"
          ],
          [
              "10000000000 100000\n",
              "447456146\n"
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
