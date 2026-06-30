Feature: APPS/interview/89 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an integer N. Consider all possible segments on the coordinate axis with endpoints at integer points with coordinates between 0 and N, inclusive; there will be $\frac{n(n + 1)}{2}$ of them.

      You want to draw these segments in several layers so that in each layer the segments don't overlap (they might touch at the endpoints though). You can not move the segments to a different location on the coordinate axis. 

      Find the minimal number of layers you have to use for the given N.


      -----Input-----

      The only input line contains a single integer N (1 ≤ N ≤ 100).


      -----Output-----

      Output a single integer - the minimal number of layers required to draw the segments for the given N.


      -----Examples-----
      Input
      2

      Output
      2

      Input
      3

      Output
      4

      Input
      4

      Output
      6



      -----Note-----

      As an example, here are the segments and their optimal arrangement into layers for N = 4. [Image]

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "2\n",
              "2\n"
          ],
          [
              "3\n",
              "4\n"
          ],
          [
              "4\n",
              "6\n"
          ],
          [
              "21\n",
              "121\n"
          ],
          [
              "100\n",
              "2550\n"
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
