Feature: APPS/interview/1 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Anton has the integer x. He is interested what positive integer, which doesn't exceed x, has the maximum sum of digits.

      Your task is to help Anton and to find the integer that interests him. If there are several such integers, determine the biggest of them. 


      -----Input-----

      The first line contains the positive integer x (1 ≤ x ≤ 10^18) — the integer which Anton has. 


      -----Output-----

      Print the positive integer which doesn't exceed x and has the maximum sum of digits. If there are several such integers, print the biggest of them. Printed integer must not contain leading zeros.


      -----Examples-----
      Input
      100

      Output
      99

      Input
      48

      Output
      48

      Input
      521

      Output
      499

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "100\n",
              "99\n"
          ],
          [
              "48\n",
              "48\n"
          ],
          [
              "521\n",
              "499\n"
          ],
          [
              "1\n",
              "1\n"
          ],
          [
              "2\n",
              "2\n"
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
