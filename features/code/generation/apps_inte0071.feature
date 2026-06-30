Feature: APPS/interview/71 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      On the Literature lesson Sergei noticed an awful injustice, it seems that some students are asked more often than others.

      Seating in the class looks like a rectangle, where n rows with m pupils in each. 

      The teacher asks pupils in the following order: at first, she asks all pupils from the first row in the order of their seating, then she continues to ask pupils from the next row. If the teacher asked the last row, then the direction of the poll changes, it means that she asks the previous row. The order of asking the rows looks as follows: the 1-st row, the 2-nd row, ..., the n - 1-st row, the n-th row, the n - 1-st row, ..., the 2-nd row, the 1-st row, the 2-nd row, ...

      The order of asking of pupils on the same row is always the same: the 1-st pupil, the 2-nd pupil, ..., the m-th pupil.

      During the lesson the teacher managed to ask exactly k questions from pupils in order described above. Sergei seats on the x-th row, on the y-th place in the row. Sergei decided to prove to the teacher that pupils are asked irregularly, help him count three values:  the maximum number of questions a particular pupil is asked,  the minimum number of questions a particular pupil is asked,  how many times the teacher asked Sergei. 

      If there is only one row in the class, then the teacher always asks children from this row.


      -----Input-----

      The first and the only line contains five integers n, m, k, x and y (1 ≤ n, m ≤ 100, 1 ≤ k ≤ 10^18, 1 ≤ x ≤ n, 1 ≤ y ≤ m).


      -----Output-----

      Print three integers:  the maximum number of questions a particular pupil is asked,  the minimum number of questions a particular pupil is asked,  how many times the teacher asked Sergei. 


      -----Examples-----
      Input
      1 3 8 1 1

      Output
      3 2 3
      Input
      4 2 9 4 2

      Output
      2 1 1
      Input
      5 5 25 4 3

      Output
      1 1 1
      Input
      100 100 1000000000000000000 100 100

      Output
      101010101010101 50505050505051 50505050505051


      -----Note-----

      The order of asking pupils in the first test:   the pupil from the first row who seats at the
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
              "1 3 8 1 1\n",
              "3 2 3"
          ],
          [
              "4 2 9 4 2\n",
              "2 1 1"
          ],
          [
              "5 5 25 4 3\n",
              "1 1 1"
          ],
          [
              "100 100 1000000000000000000 100 100\n",
              "101010101010101 50505050505051 50505050505051"
          ],
          [
              "3 2 15 2 2\n",
              "4 2 3"
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
