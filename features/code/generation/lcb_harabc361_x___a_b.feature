Feature: LiveCodeBench/atcoder/hard — x = a^b
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      How many integers x between 1 and N, inclusive, can be expressed as x = a^b using some positive integer a and a positive integer b not less than 2?

      Input

      The input is given from Standard Input in the following format:
      N

      Output

      Print the answer as an integer.

      Constraints


      - All input values are integers.
      - 1 \le N \le 10^{18}

      Sample Input 1

      99

      Sample Output 1

      12

      The integers that satisfy the conditions in the problem statement are 1, 4, 8, 9, 16, 25, 27, 32, 36, 49, 64, 81: there are 12.

      Sample Input 2

      1000000000000000000

      Sample Output 2

      1001003332

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "99\n",
              "12\n"
          ],
          [
              "1000000000000000000\n",
              "1001003332\n"
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
