Feature: APPS/interview/41 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given the array of integer numbers a_0, a_1, ..., a_{n} - 1. For each element find the distance to the nearest zero (to the element which equals to zero). There is at least one zero element in the given array.


      -----Input-----

      The first line contains integer n (1 ≤ n ≤ 2·10^5) — length of the array a. The second line contains integer elements of the array separated by single spaces ( - 10^9 ≤ a_{i} ≤ 10^9).


      -----Output-----

      Print the sequence d_0, d_1, ..., d_{n} - 1, where d_{i} is the difference of indices between i and nearest j such that a_{j} = 0. It is possible that i = j.


      -----Examples-----
      Input
      9
      2 1 0 3 0 0 3 2 4

      Output
      2 1 0 1 0 0 1 2 3 
      Input
      5
      0 1 2 3 4

      Output
      0 1 2 3 4 
      Input
      7
      5 6 0 1 -2 3 4

      Output
      2 1 0 1 2 3 4

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "9\n2 1 0 3 0 0 3 2 4\n",
              "2 1 0 1 0 0 1 2 3 "
          ],
          [
              "5\n0 1 2 3 4\n",
              "0 1 2 3 4 "
          ],
          [
              "7\n5 6 0 1 -2 3 4\n",
              "2 1 0 1 2 3 4 "
          ],
          [
              "1\n0\n",
              "0 "
          ],
          [
              "2\n0 0\n",
              "0 0 "
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
