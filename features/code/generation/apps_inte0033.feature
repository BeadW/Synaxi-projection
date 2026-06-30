Feature: APPS/interview/33 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given two arithmetic progressions: a_1k + b_1 and a_2l + b_2. Find the number of integers x such that L ≤ x ≤ R and x = a_1k' + b_1 = a_2l' + b_2, for some integers k', l' ≥ 0.


      -----Input-----

      The only line contains six integers a_1, b_1, a_2, b_2, L, R (0 < a_1, a_2 ≤ 2·10^9,  - 2·10^9 ≤ b_1, b_2, L, R ≤ 2·10^9, L ≤ R).


      -----Output-----

      Print the desired number of integers x.


      -----Examples-----
      Input
      2 0 3 3 5 21

      Output
      3

      Input
      2 4 3 0 6 17

      Output
      2

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "2 0 3 3 5 21\n",
              "3\n"
          ],
          [
              "2 4 3 0 6 17\n",
              "2\n"
          ],
          [
              "2 0 4 2 -39 -37\n",
              "0\n"
          ],
          [
              "1 9 3 11 49 109\n",
              "20\n"
          ],
          [
              "3 81 5 72 -1761 501\n",
              "28\n"
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
