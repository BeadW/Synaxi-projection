Feature: APPS/interview/57 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      After making bad dives into swimming pools, Wilbur wants to build a swimming pool in the shape of a rectangle in his backyard. He has set up coordinate axes, and he wants the sides of the rectangle to be parallel to them. Of course, the area of the rectangle must be positive. Wilbur had all four vertices of the planned pool written on a paper, until his friend came along and erased some of the vertices.

      Now Wilbur is wondering, if the remaining n vertices of the initial rectangle give enough information to restore the area of the planned swimming pool.


      -----Input-----

      The first line of the input contains a single integer n (1 ≤ n ≤ 4) — the number of vertices that were not erased by Wilbur's friend.

      Each of the following n lines contains two integers x_{i} and y_{i} ( - 1000 ≤ x_{i}, y_{i} ≤ 1000) —the coordinates of the i-th vertex that remains. Vertices are given in an arbitrary order.

      It's guaranteed that these points are distinct vertices of some rectangle, that has positive area and which sides are parallel to the coordinate axes.


      -----Output-----

      Print the area of the initial rectangle if it could be uniquely determined by the points remaining. Otherwise, print  - 1. 


      -----Examples-----
      Input
      2
      0 0
      1 1

      Output
      1

      Input
      1
      1 1

      Output
      -1



      -----Note-----

      In the first sample, two opposite corners of the initial rectangle are given, and that gives enough information to say that the rectangle is actually a unit square.

      In the second sample there is only one vertex left and this is definitely not enough to uniquely define the area.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "2\n0 0\n1 1\n",
              "1\n"
          ],
          [
              "1\n1 1\n",
              "-1\n"
          ],
          [
              "1\n-188 17\n",
              "-1\n"
          ],
          [
              "1\n71 -740\n",
              "-1\n"
          ],
          [
              "4\n-56 -858\n-56 -174\n778 -858\n778 -174\n",
              "570456\n"
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
