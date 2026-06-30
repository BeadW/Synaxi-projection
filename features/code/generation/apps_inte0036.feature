Feature: APPS/interview/36 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Ayrat is looking for the perfect code. He decided to start his search from an infinite field tiled by hexagons. For convenience the coordinate system is introduced, take a look at the picture to see how the coordinates of hexagon are defined: 

      [Image] [Image] Ayrat is searching through the field. He started at point (0, 0) and is moving along the spiral (see second picture). Sometimes he forgets where he is now. Help Ayrat determine his location after n moves.


      -----Input-----

      The only line of the input contains integer n (0 ≤ n ≤ 10^18) — the number of Ayrat's moves.


      -----Output-----

      Print two integers x and y — current coordinates of Ayrat coordinates.


      -----Examples-----
      Input
      3

      Output
      -2 0

      Input
      7

      Output
      3 2

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "3\n",
              "-2 0\n"
          ],
          [
              "7\n",
              "3 2\n"
          ],
          [
              "39\n",
              "5 6\n"
          ],
          [
              "14\n",
              "-2 -4\n"
          ],
          [
              "94\n",
              "8 8\n"
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
