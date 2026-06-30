Feature: APPS/interview/80 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Today on Informatics class Nastya learned about GCD and LCM (see links below). Nastya is very intelligent, so she solved all the tasks momentarily and now suggests you to solve one of them as well.

      We define a pair of integers (a, b) good, if GCD(a, b) = x and LCM(a, b) = y, where GCD(a, b) denotes the greatest common divisor of a and b, and LCM(a, b) denotes the least common multiple of a and b.

      You are given two integers x and y. You are to find the number of good pairs of integers (a, b) such that l ≤ a, b ≤ r. Note that pairs (a, b) and (b, a) are considered different if a ≠ b.


      -----Input-----

      The only line contains four integers l, r, x, y (1 ≤ l ≤ r ≤ 10^9, 1 ≤ x ≤ y ≤ 10^9).


      -----Output-----

      In the only line print the only integer — the answer for the problem.


      -----Examples-----
      Input
      1 2 1 2

      Output
      2

      Input
      1 12 1 12

      Output
      4

      Input
      50 100 3 30

      Output
      0



      -----Note-----

      In the first example there are two suitable good pairs of integers (a, b): (1, 2) and (2, 1).

      In the second example there are four suitable good pairs of integers (a, b): (1, 12), (12, 1), (3, 4) and (4, 3).

      In the third example there are good pairs of integers, for example, (3, 30), but none of them fits the condition l ≤ a, b ≤ r.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "1 2 1 2\n",
              "2\n"
          ],
          [
              "1 12 1 12\n",
              "4\n"
          ],
          [
              "50 100 3 30\n",
              "0\n"
          ],
          [
              "1 1000000000 1 1000000000\n",
              "4\n"
          ],
          [
              "1 1000000000 158260522 200224287\n",
              "0\n"
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
