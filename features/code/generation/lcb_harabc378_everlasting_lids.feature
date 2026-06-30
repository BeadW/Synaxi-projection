Feature: LiveCodeBench/atcoder/hard — Everlasting LIDS
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given integers A, B, and M.
      How many permutations P = (P_1, \dots, P_{AB-1}) of (1, 2, \ldots, AB - 1) satisfy all of the following conditions? Find the count modulo M.

      - The length of a longest increasing subsequence of P is A.
      - The length of a longest decreasing subsequence of P is B.
      - There exists an integer n such that appending n + 0.5 to the end of P does not change either of the lengths of a longest increasing subsequence and a longest decreasing subsequence.

      Input

      The input is given from Standard Input in the following format:
      A B M

      Output

      Print the number of permutations satisfying the conditions, modulo M.

      Constraints


      - All input values are integers.
      - 2 \leq A, B
      - AB \leq 120
      - 10^8 \leq M \leq 10^9
      - M is a prime.

      Sample Input 1

      3 2 998244353

      Sample Output 1

      10

      For example, P = (2, 4, 5, 1, 3) satisfies the conditions. This can be confirmed as follows:

      - The length of a longest increasing subsequence of P is 3.
      - The length of a longest decreasing subsequence of P is 2.
      - For n = 4, the lengths of longest increasing and decreasing subsequences of (2, 4, 5, 1, 3, 4.5) are 3 and 2, respectively.

      There are 10 permutations of (1, 2, 3, 4, 5) that satisfy the conditions.

      Sample Input 2

      10 12 924844033

      Sample Output 2

      623378361

      Print the count modulo M.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 2 998244353",
              "10"
          ],
          [
              "10 12 924844033",
              "623378361"
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
