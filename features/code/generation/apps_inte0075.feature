Feature: APPS/interview/75 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a description of a depot. It is a rectangular checkered field of n × m size. Each cell in a field can be empty (".") or it can be occupied by a wall ("*"). 

      You have one bomb. If you lay the bomb at the cell (x, y), then after triggering it will wipe out all walls in the row x and all walls in the column y.

      You are to determine if it is possible to wipe out all walls in the depot by placing and triggering exactly one bomb. The bomb can be laid both in an empty cell or in a cell occupied by a wall.


      -----Input-----

      The first line contains two positive integers n and m (1 ≤ n, m ≤ 1000) — the number of rows and columns in the depot field. 

      The next n lines contain m symbols "." and "*" each — the description of the field. j-th symbol in i-th of them stands for cell (i, j). If the symbol is equal to ".", then the corresponding cell is empty, otherwise it equals "*" and the corresponding cell is occupied by a wall.


      -----Output-----

      If it is impossible to wipe out all walls by placing and triggering exactly one bomb, then print "NO" in the first line (without quotes).

      Otherwise print "YES" (without quotes) in the first line and two integers in the second line — the coordinates of the cell at which the bomb should be laid. If there are multiple answers, print any of them.


      -----Examples-----
      Input
      3 4
      .*..
      ....
      .*..

      Output
      YES
      1 2

      Input
      3 3
      ..*
      .*.
      *..

      Output
      NO

      Input
      6 5
      ..*..
      ..*..
      *****
      ..*..
      ..*..
      ..*..

      Output
      YES
      3 3

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "3 4\n.*..\n....\n.*..\n",
              "YES\n1 2\n"
          ],
          [
              "3 3\n..*\n.*.\n*..\n",
              "NO\n"
          ],
          [
              "6 5\n..*..\n..*..\n*****\n..*..\n..*..\n..*..\n",
              "YES\n3 3\n"
          ],
          [
              "1 10\n**********\n",
              "YES\n1 1\n"
          ],
          [
              "10 1\n*\n*\n*\n*\n*\n*\n*\n*\n*\n*\n",
              "YES\n1 1\n"
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
