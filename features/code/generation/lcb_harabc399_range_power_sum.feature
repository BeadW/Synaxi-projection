Feature: LiveCodeBench/atcoder/hard — Range Power Sum
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given positive integers N, K, and an integer sequence of length N: A = (A_1, A_2, \dots, A_N).
      Find \displaystyle \sum_{1\leq l\leq r\leq N} \Bigg(\sum_{l\leq i\leq r} A_i\Bigg)^K, modulo 998244353.

      Input

      The input is given from Standard Input in the following format:
      N K
      A_1 A_2 \dots A_N

      Output

      Print the answer.

      Constraints


      - 1\leq N \leq 2\times 10^5
      - 1\leq K \leq 10
      - 0 \leq A_i < 998244353
      - All input values are integers.

      Sample Input 1

      3 2
      3 1 2

      Sample Output 1

      75

      The value is A_1^2+A_2^2+A_3^2+(A_1+A_2)^2+(A_2+A_3)^2+(A_1+A_2+A_3)^2=3^2+1^2+2^2+4^2+3^2+6^2=75.

      Sample Input 2

      1 10
      0

      Sample Output 2

      0

      Sample Input 3

      10 5
      91 59 85 60 57 72 12 3 27 16

      Sample Output 3

      428633385

      Be sure to find the sum modulo 998244353.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 2\n3 1 2",
              "75"
          ],
          [
              "1 10\n0",
              "0"
          ],
          [
              "10 5\n91 59 85 60 57 72 12 3 27 16",
              "428633385"
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
