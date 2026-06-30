Feature: APPS/interview/99 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Masha really loves algebra. On the last lesson, her strict teacher Dvastan gave she new exercise.

      You are given geometric progression b defined by two integers b_1 and q. Remind that a geometric progression is a sequence of integers b_1, b_2, b_3, ..., where for each i > 1 the respective term satisfies the condition b_{i} = b_{i} - 1·q, where q is called the common ratio of the progression. Progressions in Uzhlyandia are unusual: both b_1 and q can equal 0. Also, Dvastan gave Masha m "bad" integers a_1, a_2, ..., a_{m}, and an integer l.

      Masha writes all progression terms one by one onto the board (including repetitive) while condition |b_{i}| ≤ l is satisfied (|x| means absolute value of x). There is an exception: if a term equals one of the "bad" integers, Masha skips it (doesn't write onto the board) and moves forward to the next term.

      But the lesson is going to end soon, so Masha has to calculate how many integers will be written on the board. In order not to get into depression, Masha asked you for help: help her calculate how many numbers she will write, or print "inf" in case she needs to write infinitely many integers.


      -----Input-----

      The first line of input contains four integers b_1, q, l, m (-10^9 ≤ b_1, q ≤ 10^9, 1 ≤ l ≤ 10^9, 1 ≤ m ≤ 10^5) — the initial term and the common ratio of progression, absolute value of maximal number that can be written on the board and the number of "bad" integers, respectively.

      The second line contains m distinct integers a_1, a_2, ..., a_{m} (-10^9 ≤ a_{i} ≤ 10^9) — numbers that will never be written on the board.


      -----Output-----

      Print the only integer, meaning the number of progression terms that will be written on the board if it is finite, or "inf" (without quotes) otherwise.


      -----Examples-----
      Input
      3 2 30 4
      6 14 25 48

      Output
      3
      Input
      123 1 2143435 4
      123 11 -5453 141245

      Output
      0
      Input
      123 1 2143435 4
      54343 -13 6 124

      Output
      inf


      -----Note-----

      In the first sample case, Masha will write integers 3, 12, 24
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
              "3 2 30 4\n6 14 25 48\n",
              "3"
          ],
          [
              "123 1 2143435 4\n123 11 -5453 141245\n",
              "0"
          ],
          [
              "123 1 2143435 4\n54343 -13 6 124\n",
              "inf"
          ],
          [
              "3 2 25 2\n379195692 -69874783\n",
              "4"
          ],
          [
              "3 2 30 3\n-691070108 -934106649 -220744807\n",
              "4"
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
