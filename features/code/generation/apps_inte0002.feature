Feature: APPS/interview/2 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Apart from having lots of holidays throughout the year, residents of Berland also have whole lucky years. Year is considered lucky if it has no more than 1 non-zero digit in its number. So years 100, 40000, 5 are lucky and 12, 3001 and 12345 are not.

      You are given current year in Berland. Your task is to find how long will residents of Berland wait till the next lucky year.


      -----Input-----

      The first line contains integer number n (1 ≤ n ≤ 10^9) — current year in Berland.


      -----Output-----

      Output amount of years from the current year to the next lucky one.


      -----Examples-----
      Input
      4

      Output
      1

      Input
      201

      Output
      99

      Input
      4000

      Output
      1000



      -----Note-----

      In the first example next lucky year is 5. In the second one — 300. In the third — 5000.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "4\n",
              "1\n"
          ],
          [
              "201\n",
              "99\n"
          ],
          [
              "4000\n",
              "1000\n"
          ],
          [
              "9\n",
              "1\n"
          ],
          [
              "10\n",
              "10\n"
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
