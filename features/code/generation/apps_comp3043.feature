Feature: APPS/competition/3043 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are a treasure hunter searching for gold in the wild. Luckily you got a map of the area from a black marketeer. The map clearly shows where a box of gold is along with the surrounding terrain. Of course, you want to head to the treasure as fast as possible. However, the trip might not be easy.

      The area is described by a grid of $N$ rows and $M$ columns. You are currently located at the cell labeled ‘S’. The treasure is located at the cell labeled ‘G’. Despite your eagerness for the treasure, you cannot keep moving tirelessly. The surrounding area has different landforms: plain (‘.’), forest (‘F’), mountain (‘M’) or river (‘#’). Rivers are impassable since no boats are currently available. You can navigate in four directions (up, down, left, right) between neighboring cells.

      At the beginning of your trip you have $K$ stamina points. Moving onto a plain, forest, and mountain costs you $1$, $2$, and $3$ points of stamina respectively. Once you run out of stamina and can no longer move to nearby cells, you must camp and rest. Your stamina is replenished to the full $K$ points on the second day so that you can start moving again.

      Plan wisely with the map and determine the minimum number of days you need to reach the treasure.

      -----Input-----
      The first line has three integers $N$, $M$ ($1\leq N, M \leq 50$), and $K$ ($1 \leq K \leq 100$). Each of the next $N$ lines has $M$ characters describing the grid shown by the treasure map. The grid contains only characters ‘.’, ‘F’, ‘M’, ‘#’, ‘S’, and ‘G’. It is guaranteed that ‘S’ and ‘G’ appear exactly once in the grid. You may assume your starting point (‘S’) and the treasure (‘G’) are both on a plain.

      -----Output-----
      Output the minimum number of days you need to reach the treasure. If it is impossible to get to the treasure, output “-1”.

      -----Examples-----
      Sample Input 1:
      2 5 4
      S#.F.
      .MFMG
      Sample Output 1:
      3

      Sample Input 2:
      1 2 1
      GS
      Sample Output 2:
      1

      Sample Input 3:
      2 2 10
      S#
      #G
      Sample Output 3:
      -1

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "2 5 4\nS#.F.\n.MFMG\n",
              "3\n"
          ],
          [
              "1 2 1\nGS\n",
              "1\n"
          ],
          [
              "2 2 10\nS#\n#G\n",
              "-1\n"
          ],
          [
              "1 7 4\nSMMMMMG\n",
              "5\n"
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
