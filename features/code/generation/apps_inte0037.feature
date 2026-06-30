Feature: APPS/interview/37 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Dante is engaged in a fight with "The Savior". Before he can fight it with his sword, he needs to break its shields. He has two guns, Ebony and Ivory, each of them is able to perform any non-negative number of shots.

      For every bullet that hits the shield, Ebony deals a units of damage while Ivory deals b units of damage. In order to break the shield Dante has to deal exactly c units of damage. Find out if this is possible.


      -----Input-----

      The first line of the input contains three integers a, b, c (1 ≤ a, b ≤ 100, 1 ≤ c ≤ 10 000) — the number of units of damage dealt by Ebony gun and Ivory gun, and the total number of damage required to break the shield, respectively.


      -----Output-----

      Print "Yes" (without quotes) if Dante can deal exactly c damage to the shield and "No" (without quotes) otherwise.


      -----Examples-----
      Input
      4 6 15

      Output
      No

      Input
      3 2 7

      Output
      Yes

      Input
      6 11 6

      Output
      Yes



      -----Note-----

      In the second sample, Dante can fire 1 bullet from Ebony and 2 from Ivory to deal exactly 1·3 + 2·2 = 7 damage. In the third sample, Dante can fire 1 bullet from ebony and no bullets from ivory to do 1·6 + 0·11 = 6 damage.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "4 6 15\n",
              "No\n"
          ],
          [
              "3 2 7\n",
              "Yes\n"
          ],
          [
              "6 11 6\n",
              "Yes\n"
          ],
          [
              "3 12 15\n",
              "Yes\n"
          ],
          [
              "5 5 10\n",
              "Yes\n"
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
