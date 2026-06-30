Feature: APPS/interview/32 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      In this problem we assume the Earth to be a completely round ball and its surface a perfect sphere. The length of the equator and any meridian is considered to be exactly 40 000 kilometers. Thus, travelling from North Pole to South Pole or vice versa takes exactly 20 000 kilometers.

      Limak, a polar bear, lives on the North Pole. Close to the New Year, he helps somebody with delivering packages all around the world. Instead of coordinates of places to visit, Limak got a description how he should move, assuming that he starts from the North Pole. The description consists of n parts. In the i-th part of his journey, Limak should move t_{i} kilometers in the direction represented by a string dir_{i} that is one of: "North", "South", "West", "East".

      Limak isn’t sure whether the description is valid. You must help him to check the following conditions:  If at any moment of time (before any of the instructions or while performing one of them) Limak is on the North Pole, he can move only to the South.  If at any moment of time (before any of the instructions or while performing one of them) Limak is on the South Pole, he can move only to the North.  The journey must end on the North Pole. 

      Check if the above conditions are satisfied and print "YES" or "NO" on a single line.


      -----Input-----

      The first line of the input contains a single integer n (1 ≤ n ≤ 50).

      The i-th of next n lines contains an integer t_{i} and a string dir_{i} (1 ≤ t_{i} ≤ 10^6, $\operatorname{dir}_{i} \in \{\text{North, South, West, East} \}$) — the length and the direction of the i-th part of the journey, according to the description Limak got.


      -----Output-----

      Print "YES" if the description satisfies the three conditions, otherwise print "NO", both without the quotes.


      -----Examples-----
      Input
      5
      7500 South
      10000 East
      3500 North
      4444 West
      4000 North

      Output
      YES

      Input
      2
      15000 South
      4000 East

      Output
      NO

      Input
      5
      20000 South
      1000 North
      1000000 West
      9000 North
      10000 North

      Output
      YES

      Input
      3
      200
      ...(truncated)

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "5\n7500 South\n10000 East\n3500 North\n4444 West\n4000 North\n",
              "YES\n"
          ],
          [
              "2\n15000 South\n4000 East\n",
              "NO\n"
          ],
          [
              "5\n20000 South\n1000 North\n1000000 West\n9000 North\n10000 North\n",
              "YES\n"
          ],
          [
              "3\n20000 South\n10 East\n20000 North\n",
              "NO\n"
          ],
          [
              "2\n1000 North\n1000 South\n",
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
