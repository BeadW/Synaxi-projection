Feature: APPS/competition/3010 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Peter is bored during his operating systems class, so he draws doodles on a sheet of paper. He feels like drawing abstract art using his ruler: he draws line segments by choosing two points in the plane and connecting them. Lots of them.

      Can you write a program that counts the number of distinct points at which the line segments he drew intersect or touch?

      -----Input-----
      The first line in the input contains an integer $n$ ($1 \le n \le 1000$) which is the number of lines. The following $n$ lines contain four integers $x_0 \ \ y_0 \ \ x_1 \ \ y_1$ ($-1000000 \le x_0, \ y_0, \ x_1, \ y_1 \le 1000000$). Lines have non-zero length, i.e., the two points will be distinct: $x_0 \ne x_1$ or $y_0 \ne y_1$ or both.

      -----Output-----
      Output the number of distinct points for which there is at least one pair of line segments that intersects or touches at this point. If there are infinitely many such points, output -1.

      -----Examples-----
      Sample Input 1:
      3
      1 3 9 5
      2 2 6 8
      4 8 9 3
      Sample Output 1:
      3

      Sample Input 2:
      3
      5 2 7 10
      7 4 4 10
      2 4 10 8
      Sample Output 2:
      1

      Sample Input 3:
      3
      2 1 6 5
      2 5 5 4
      5 1 7 7
      Sample Output 3:
      1

      Sample Input 4:
      2
      -1 -2 -1 -1
      -1 2 -1 -1
      Sample Output 4:
      1

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "3\n1 3 9 5\n2 2 6 8\n4 8 9 3\n",
              "3\n"
          ],
          [
              "3\n5 2 7 10\n7 4 4 10\n2 4 10 8\n",
              "1\n"
          ],
          [
              "3\n2 1 6 5\n2 5 5 4\n5 1 7 7\n",
              "1\n"
          ],
          [
              "2\n-1 -2 -1 -1\n-1 2 -1 -1\n",
              "1\n"
          ],
          [
              "2\n0 0 2 2\n1 1 -5 -5\n",
              "-1\n"
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
