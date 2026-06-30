Feature: APPS/interview/56 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Mary has just graduated from one well-known University and is now attending celebration party. Students like to dream of a beautiful life, so they used champagne glasses to construct a small pyramid. The height of the pyramid is n. The top level consists of only 1 glass, that stands on 2 glasses on the second level (counting from the top), then 3 glasses on the third level and so on.The bottom level consists of n glasses.

      Vlad has seen in the movies many times how the champagne beautifully flows from top levels to bottom ones, filling all the glasses simultaneously. So he took a bottle and started to pour it in the glass located at the top of the pyramid.

      Each second, Vlad pours to the top glass the amount of champagne equal to the size of exactly one glass. If the glass is already full, but there is some champagne flowing in it, then it pours over the edge of the glass and is equally distributed over two glasses standing under. If the overflowed glass is at the bottom level, then the champagne pours on the table. For the purpose of this problem we consider that champagne is distributed among pyramid glasses immediately. Vlad is interested in the number of completely full glasses if he stops pouring champagne in t seconds.

      Pictures below illustrate the pyramid consisting of three levels. [Image] [Image] 


      -----Input-----

      The only line of the input contains two integers n and t (1 ≤ n ≤ 10, 0 ≤ t ≤ 10 000) — the height of the pyramid and the number of seconds Vlad will be pouring champagne from the bottle.


      -----Output-----

      Print the single integer — the number of completely full glasses after t seconds.


      -----Examples-----
      Input
      3 5

      Output
      4

      Input
      4 8

      Output
      6



      -----Note-----

      In the first sample, the glasses full after 5 seconds are: the top glass, both glasses on the second level and the middle glass at the bottom level. Left and right glasses of the bottom level will be half-empty.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "3 5\n",
              "4\n"
          ],
          [
              "4 8\n",
              "6\n"
          ],
          [
              "1 1\n",
              "1\n"
          ],
          [
              "10 10000\n",
              "55\n"
          ],
          [
              "1 10000\n",
              "1\n"
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
