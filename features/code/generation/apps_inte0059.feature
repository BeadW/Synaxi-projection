Feature: APPS/interview/59 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You have an array a consisting of n integers. Each integer from 1 to n appears exactly once in this array.

      For some indices i (1 ≤ i ≤ n - 1) it is possible to swap i-th element with (i + 1)-th, for other indices it is not possible. You may perform any number of swapping operations any order. There is no limit on the number of times you swap i-th element with (i + 1)-th (if the position is not forbidden).

      Can you make this array sorted in ascending order performing some sequence of swapping operations?


      -----Input-----

      The first line contains one integer n (2 ≤ n ≤ 200000) — the number of elements in the array.

      The second line contains n integers a_1, a_2, ..., a_{n} (1 ≤ a_{i} ≤ 200000) — the elements of the array. Each integer from 1 to n appears exactly once.

      The third line contains a string of n - 1 characters, each character is either 0 or 1. If i-th character is 1, then you can swap i-th element with (i + 1)-th any number of times, otherwise it is forbidden to swap i-th element with (i + 1)-th.


      -----Output-----

      If it is possible to sort the array in ascending order using any sequence of swaps you are allowed to make, print YES. Otherwise, print NO.


      -----Examples-----
      Input
      6
      1 2 5 3 4 6
      01110

      Output
      YES

      Input
      6
      1 2 5 3 4 6
      01010

      Output
      NO



      -----Note-----

      In the first example you may swap a_3 and a_4, and then swap a_4 and a_5.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "6\n1 2 5 3 4 6\n01110\n",
              "YES\n"
          ],
          [
              "6\n1 2 5 3 4 6\n01010\n",
              "NO\n"
          ],
          [
              "6\n1 6 3 4 5 2\n01101\n",
              "NO\n"
          ],
          [
              "6\n2 3 1 4 5 6\n01111\n",
              "NO\n"
          ],
          [
              "4\n2 3 1 4\n011\n",
              "NO\n"
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
