Feature: LiveCodeBench/atcoder/hard — Alphabet Tiles
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      AtCoder Land sells tiles with English letters written on them. Takahashi is thinking of making a nameplate by arranging these tiles in a row.

      Find the number, modulo 998244353, of strings consisting of uppercase English letters with a length between 1 and K, inclusive, that satisfy the following conditions:

      - For every integer i satisfying 1 \leq i \leq 26, the following holds:
      - Let a_i be the i-th uppercase English letter in lexicographical order. For example, a_1 =  A, a_5 =  E, a_{26} =  Z.
      - The number of occurrences of a_i in the string is between 0 and C_i, inclusive.

      Input

      The input is given from Standard Input in the following format:
      K
      C_1 C_2 \ldots C_{26}

      Output

      Print the answer.

      Constraints


      - 1 \leq K \leq 1000
      - 0 \leq C_i \leq 1000
      - All input values are integers.

      Sample Input 1

      2
      2 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

      Sample Output 1

      10

      The 10 strings that satisfy the conditions are A, B, C, AA, AB, AC, BA, BC, CA, CB.

      Sample Input 2

      358
      1 0 1 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

      Sample Output 2

      64

      Sample Input 3

      1000
      1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000

      Sample Output 3

      270274035

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "2\n2 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0\n",
              "10\n"
          ],
          [
              "358\n1 0 1 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0\n",
              "64\n"
          ],
          [
              "1000\n1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000\n",
              "270274035\n"
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
