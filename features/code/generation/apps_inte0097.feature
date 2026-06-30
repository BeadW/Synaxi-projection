Feature: APPS/interview/97 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Consider a billiard table of rectangular size $n \times m$ with four pockets. Let's introduce a coordinate system with the origin at the lower left corner (see the picture).  [Image] 

      There is one ball at the point $(x, y)$ currently. Max comes to the table and strikes the ball. The ball starts moving along a line that is parallel to one of the axes or that makes a $45^{\circ}$ angle with them. We will assume that:   the angles between the directions of the ball before and after a collision with a side are equal,  the ball moves indefinitely long, it only stops when it falls into a pocket,  the ball can be considered as a point, it falls into a pocket if and only if its coordinates coincide with one of the pockets,  initially the ball is not in a pocket. 

      Note that the ball can move along some side, in this case the ball will just fall into the pocket at the end of the side.

      Your task is to determine whether the ball will fall into a pocket eventually, and if yes, which of the four pockets it will be.


      -----Input-----

      The only line contains $6$ integers $n$, $m$, $x$, $y$, $v_x$, $v_y$ ($1 \leq n, m \leq 10^9$, $0 \leq x \leq n$; $0 \leq y \leq m$; $-1 \leq v_x, v_y \leq 1$; $(v_x, v_y) \neq (0, 0)$) — the width of the table, the length of the table, the $x$-coordinate of the initial position of the ball, the $y$-coordinate of the initial position of the ball, the $x$-component of its initial speed and the $y$-component of its initial speed, respectively. It is guaranteed that the ball is not initially in a pocket.


      -----Output-----

      Print the coordinates of the pocket the ball will fall into, or $-1$ if the ball will move indefinitely.


      -----Examples-----
      Input
      4 3 2 2 -1 1

      Output
      0 0
      Input
      4 4 2 0 1 1

      Output
      -1
      Input
      10 10 10 1 -1 0

      Output
      -1


      -----Note-----

      The first sample:  [Image] 

      The second sample:  [Image] 

      In the third sample the ball will never change its $y$ coordinate, so the ball will never fall into a pocket.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "4 3 2 2 -1 1\n",
              "0 0"
          ],
          [
              "4 4 2 0 1 1\n",
              "-1"
          ],
          [
              "10 10 10 1 -1 0\n",
              "-1"
          ],
          [
              "1000000000 1000000000 1 1000000000 0 1\n",
              "-1"
          ],
          [
              "2 1 1 0 -1 -1\n",
              "0 1"
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
