Feature: APPS/interview/87 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Petr wants to make a calendar for current month. For this purpose he draws a table in which columns correspond to weeks (a week is seven consequent days from Monday to Sunday), rows correspond to weekdays, and cells contain dates. For example, a calendar for January 2017 should look like on the picture: $\left. \begin{array}{|r|r|r|r|r|r|} \hline & {2} & {9} & {16} & {23} & {30} \\ \hline & {3} & {10} & {17} & {24} & {31} \\ \hline & {4} & {11} & {18} & {25} & {} \\ \hline & {5} & {12} & {19} & {26} & {} \\ \hline & {6} & {13} & {20} & {27} & {} \\ \hline & {7} & {14} & {21} & {28} & {} \\ \hline 1 & {8} & {15} & {22} & {29} & {} \\ \hline \end{array} \right.$ 

      Petr wants to know how many columns his table should have given the month and the weekday of the first date of that month? Assume that the year is non-leap.


      -----Input-----

      The only line contain two integers m and d (1 ≤ m ≤ 12, 1 ≤ d ≤ 7) — the number of month (January is the first month, December is the twelfth) and the weekday of the first date of this month (1 is Monday, 7 is Sunday).


      -----Output-----

      Print single integer: the number of columns the table should have.


      -----Examples-----
      Input
      1 7

      Output
      6

      Input
      1 1

      Output
      5

      Input
      11 6

      Output
      5



      -----Note-----

      The first example corresponds to the January 2017 shown on the picture in the statements.

      In the second example 1-st January is Monday, so the whole month fits into 5 columns.

      In the third example 1-st November is Saturday and 5 columns is enough.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "1 7\n",
              "6\n"
          ],
          [
              "1 1\n",
              "5\n"
          ],
          [
              "11 6\n",
              "5\n"
          ],
          [
              "2 7\n",
              "5\n"
          ],
          [
              "2 1\n",
              "4\n"
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
