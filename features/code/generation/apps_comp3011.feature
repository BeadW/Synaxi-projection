Feature: APPS/competition/3011 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      A Hill Number is a positive integer, the digits of which possibly rise and then possibly fall, but never fall and then rise. For example:12321 is a hill number.

      12223 is a hill number.

      33322111 is a hill number.

      1232321 is not a hill number.


      Given a positive integer, if it is a hill number, print the number of positive hill numbers less than or equal to it. If it is not a hill number, print -1.

      -----Input-----
      Each input will consist of a single test case. Note that your program may be run multiple times on different inputs. Each test case will consist of a single integer $n$ ($1 \le n \le 10^{18}$).

      -----Output-----
      Output a single line with a single integer. If the input is a hill number, then output the number of hill numbers less than or equal to it. If the input is not a hill number, then output -1.

      -----Examples-----
      Sample Input 1:
      10
      Sample Output 1:
      10

      Sample Input 2:
      55
      Sample Output 2:
      55

      Sample Input 3:
      101
      Sample Output 3:
      -1

      Sample Input 4:
      1234321
      Sample Output 4:
      94708

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "10\n",
              "10\n"
          ],
          [
              "55\n",
              "55\n"
          ],
          [
              "101\n",
              "-1\n"
          ],
          [
              "1234321\n",
              "94708\n"
          ],
          [
              "1000\n",
              "715\n"
          ]
      ]


      def test_apps():
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

  Scenario: Agent solves the APPS problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py to read from stdin and write the correct answer to stdout so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
