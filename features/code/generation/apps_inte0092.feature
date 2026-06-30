Feature: APPS/interview/92 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Let's denote d(n) as the number of divisors of a positive integer n. You are given three integers a, b and c. Your task is to calculate the following sum:

      $\sum_{i = 1}^{a} \sum_{j = 1}^{b} \sum_{k = 1}^{c} d(i \cdot j \cdot k)$

      Find the sum modulo 1073741824 (2^30).


      -----Input-----

      The first line contains three space-separated integers a, b and c (1 ≤ a, b, c ≤ 100).


      -----Output-----

      Print a single integer — the required sum modulo 1073741824 (2^30).


      -----Examples-----
      Input
      2 2 2

      Output
      20

      Input
      5 6 7

      Output
      1520



      -----Note-----

      For the first example.

        d(1·1·1) = d(1) = 1;  d(1·1·2) = d(2) = 2;  d(1·2·1) = d(2) = 2;  d(1·2·2) = d(4) = 3;  d(2·1·1) = d(2) = 2;  d(2·1·2) = d(4) = 3;  d(2·2·1) = d(4) = 3;  d(2·2·2) = d(8) = 4. 

      So the result is 1 + 2 + 2 + 3 + 2 + 3 + 3 + 4 = 20.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "2 2 2\n",
              "20\n"
          ],
          [
              "5 6 7\n",
              "1520\n"
          ],
          [
              "91 42 25\n",
              "3076687\n"
          ],
          [
              "38 47 5\n",
              "160665\n"
          ],
          [
              "82 29 45\n",
              "3504808\n"
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
