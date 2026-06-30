Feature: APPS/competition/3039 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      It is well known that a set of six unit squares that are attached together in a “cross” can be folded into a cube.

      But what about other initial shapes? That is, given six unit squares that are attached together along some of their sides, can we form a unit cube by folding this arrangement?

      -----Input-----
      Input consists of $6$ lines each containing $6$ characters, describing the initial arrangement of unit squares. Each character is either a ., meaning it is empty, or a # meaning it is a unit square.

      There are precisely $6$ occurrences of # indicating the unit squares. These form a connected component, meaning it is possible to reach any # from any other # without touching a . by making only horizontal and vertical movements. Furthermore, there is no $2 \times 2$ subsquare consisting of only #. That is, the pattern

      ##
      ##

      does not appear in the input.

      -----Output-----
      If you can fold the unit squares into a cube, display can fold. Otherwise display cannot fold.

      -----Examples-----
      Sample Input 1:
      ......
      ......
      ######
      ......
      ......
      ......
      Sample Output 1:
      cannot fold

      Sample Input 2:
      ......
      #.....
      ####..
      #.....
      ......
      ......
      Sample Output 2:
      can fold

      Sample Input 3:
      ..##..
      ...#..
      ..##..
      ...#..
      ......
      ......
      Sample Output 3:
      cannot fold

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "......\n......\n######\n......\n......\n......\n",
              "cannot fold\n"
          ],
          [
              "......\n#.....\n####..\n#.....\n......\n......\n",
              "can fold\n"
          ],
          [
              "..##..\n...#..\n..##..\n...#..\n......\n......\n",
              "cannot fold\n"
          ],
          [
              "......\n...#..\n...#..\n..###.\n..#...\n......\n",
              "can fold\n"
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
