Feature: APPS/interview/54 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Vanya has a scales for weighing loads and weights of masses w^0, w^1, w^2, ..., w^100 grams where w is some integer not less than 2 (exactly one weight of each nominal value). Vanya wonders whether he can weight an item with mass m using the given weights, if the weights can be put on both pans of the scales. Formally speaking, your task is to determine whether it is possible to place an item of mass m and some weights on the left pan of the scales, and some weights on the right pan of the scales so that the pans of the scales were in balance.


      -----Input-----

      The first line contains two integers w, m (2 ≤ w ≤ 10^9, 1 ≤ m ≤ 10^9) — the number defining the masses of the weights and the mass of the item.


      -----Output-----

      Print word 'YES' if the item can be weighted and 'NO' if it cannot.


      -----Examples-----
      Input
      3 7

      Output
      YES

      Input
      100 99

      Output
      YES

      Input
      100 50

      Output
      NO



      -----Note-----

      Note to the first sample test. One pan can have an item of mass 7 and a weight of mass 3, and the second pan can have two weights of masses 9 and 1, correspondingly. Then 7 + 3 = 9 + 1.

      Note to the second sample test. One pan of the scales can have an item of mass 99 and the weight of mass 1, and the second pan can have the weight of mass 100.

      Note to the third sample test. It is impossible to measure the weight of the item in the manner described in the input.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "3 7\n",
              "YES\n"
          ],
          [
              "100 99\n",
              "YES\n"
          ],
          [
              "100 50\n",
              "NO\n"
          ],
          [
              "1000000000 1\n",
              "YES\n"
          ],
          [
              "100 10002\n",
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
