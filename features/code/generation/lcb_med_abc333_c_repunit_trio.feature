Feature: LiveCodeBench/atcoder/medium — Repunit Trio
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      A repunit is an integer whose digits are all 1 in decimal representation. The repunits in ascending order are 1, 11, 111, \ldots.
      Find the N-th smallest integer that can be expressed as the sum of exactly three repunits.

      Input

      The input is given from Standard Input in the following format:
      N

      Output

      Print the answer.

      Constraints


      - N is an integer between 1 and 333, inclusive.

      Sample Input 1

      5

      Sample Output 1

      113

      The integers that can be expressed as the sum of exactly three repunits are 3, 13, 23, 33, 113, \ldots in ascending order. For example, 113 can be expressed as 113 = 1 + 1 + 111.
      Note that the three repunits do not have to be distinct.

      Sample Input 2

      19

      Sample Output 2

      2333

      Sample Input 3

      333

      Sample Output 3

      112222222233

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5\n",
              "113\n"
          ],
          [
              "19\n",
              "2333\n"
          ],
          [
              "333\n",
              "112222222233\n"
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
