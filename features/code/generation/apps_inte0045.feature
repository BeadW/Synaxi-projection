Feature: APPS/interview/45 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given positive integer number n. You should create such strictly increasing sequence of k positive numbers a_1, a_2, ..., a_{k}, that their sum is equal to n and greatest common divisor is maximal.

      Greatest common divisor of sequence is maximum of such numbers that every element of sequence is divisible by them.

      If there is no possible sequence then output -1.


      -----Input-----

      The first line consists of two numbers n and k (1 ≤ n, k ≤ 10^10).


      -----Output-----

      If the answer exists then output k numbers — resulting sequence. Otherwise output -1. If there are multiple answers, print any of them.


      -----Examples-----
      Input
      6 3

      Output
      1 2 3

      Input
      8 2

      Output
      2 6

      Input
      5 3

      Output
      -1

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "6 3\n",
              "1 2 3\n"
          ],
          [
              "8 2\n",
              "2 6\n"
          ],
          [
              "5 3\n",
              "-1\n"
          ],
          [
              "1 1\n",
              "1\n"
          ],
          [
              "1 2\n",
              "-1\n"
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
