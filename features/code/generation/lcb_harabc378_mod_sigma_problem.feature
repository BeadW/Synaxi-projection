Feature: LiveCodeBench/atcoder/hard — Mod Sigma Problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a sequence A = (A_1, A_2, \dots, A_N) of N non-negative integers, and a positive integer M.
      Find the following value:
      \[
      \sum_{1 \leq l \leq r \leq N} \left( \left(\sum_{l \leq i \leq r} A_i\right) \mathbin{\mathrm{mod}} M \right).
      \]
      Here, X \mathbin{\mathrm{mod}} M denotes the remainder when the non-negative integer X is divided by M.

      Input

      The input is given from Standard Input in the following format:
      N M
      A_1 A_2 \dots A_N

      Output

      Print the answer.

      Constraints


      - 1 \leq N \leq 2 \times 10^5
      - 1 \leq M \leq 2 \times 10^5
      - 0 \leq A_i \leq 10^9

      Sample Input 1

      3 4
      2 5 0

      Sample Output 1

      10


      - A_1 \mathbin{\mathrm{mod}} M = 2
      - (A_1+A_2) \mathbin{\mathrm{mod}} M = 3
      - (A_1+A_2+A_3) \mathbin{\mathrm{mod}} M = 3
      - A_2 \mathbin{\mathrm{mod}} M = 1
      - (A_2+A_3) \mathbin{\mathrm{mod}} M = 1
      - A_3 \mathbin{\mathrm{mod}} M = 0

      The answer is the sum of these values, 10. Note that the outer sum is not taken modulo M.

      Sample Input 2

      10 100
      320 578 244 604 145 839 156 857 556 400

      Sample Output 2

      2736

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 4\n2 5 0",
              "10"
          ],
          [
              "10 100\n320 578 244 604 145 839 156 857 556 400",
              "2736"
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
