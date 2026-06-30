Feature: APPS/interview/65 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an array of n integer numbers a_0, a_1, ..., a_{n} - 1. Find the distance between two closest (nearest) minimums in it. It is guaranteed that in the array a minimum occurs at least two times.


      -----Input-----

      The first line contains positive integer n (2 ≤ n ≤ 10^5) — size of the given array. The second line contains n integers a_0, a_1, ..., a_{n} - 1 (1 ≤ a_{i} ≤ 10^9) — elements of the array. It is guaranteed that in the array a minimum occurs at least two times.


      -----Output-----

      Print the only number — distance between two nearest minimums in the array.


      -----Examples-----
      Input
      2
      3 3

      Output
      1

      Input
      3
      5 6 5

      Output
      2

      Input
      9
      2 1 3 5 4 1 2 3 1

      Output
      3

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "2\n3 3\n",
              "1\n"
          ],
          [
              "3\n5 6 5\n",
              "2\n"
          ],
          [
              "9\n2 1 3 5 4 1 2 3 1\n",
              "3\n"
          ],
          [
              "6\n4 6 7 8 6 4\n",
              "5\n"
          ],
          [
              "2\n1000000000 1000000000\n",
              "1\n"
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
