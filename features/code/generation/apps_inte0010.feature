Feature: APPS/interview/10 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      On the planet Mars a year lasts exactly n days (there are no leap years on Mars). But Martians have the same weeks as earthlings — 5 work days and then 2 days off. Your task is to determine the minimum possible and the maximum possible number of days off per year on Mars.


      -----Input-----

      The first line of the input contains a positive integer n (1 ≤ n ≤ 1 000 000) — the number of days in a year on Mars.


      -----Output-----

      Print two integers — the minimum possible and the maximum possible number of days off per year on Mars.


      -----Examples-----
      Input
      14

      Output
      4 4

      Input
      2

      Output
      0 2



      -----Note-----

      In the first sample there are 14 days in a year on Mars, and therefore independently of the day a year starts with there will be exactly 4 days off .

      In the second sample there are only 2 days in a year on Mars, and they can both be either work days or days off.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "14\n",
              "4 4\n"
          ],
          [
              "2\n",
              "0 2\n"
          ],
          [
              "1\n",
              "0 1\n"
          ],
          [
              "3\n",
              "0 2\n"
          ],
          [
              "4\n",
              "0 2\n"
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
