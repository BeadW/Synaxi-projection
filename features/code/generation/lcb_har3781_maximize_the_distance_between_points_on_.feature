Feature: LiveCodeBench/leetcode/hard — maximize-the-distance-between-points-on-a-square
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an integer side, representing the edge length of a square with corners at (0, 0), (0, side), (side, 0), and (side, side) on a Cartesian plane.
      You are also given a positive integer k and a 2D integer array points, where points[i] = [x_i, y_i] represents the coordinate of a point lying on the boundary of the square.
      You need to select k elements among points such that the minimum Manhattan distance between any two points is maximized.
      Return the maximum possible minimum Manhattan distance between the selected k points.
      The Manhattan Distance between two cells (x_i, y_i) and (x_j, y_j) is |x_i - x_j| + |y_i - y_j|.
 
      Example 1:

      Input: side = 2, points = [[0,2],[2,0],[2,2],[0,0]], k = 4
      Output: 2
      Explanation:

      Select all four points.

      Example 2:

      Input: side = 2, points = [[0,0],[1,2],[2,0],[2,2],[2,1]], k = 4
      Output: 1
      Explanation:

      Select the points (0, 0), (2, 0), (2, 2), and (2, 1).

      Example 3:

      Input: side = 2, points = [[0,0],[0,1],[0,2],[1,2],[2,0],[2,2],[2,1]], k = 5
      Output: 1
      Explanation:

      Select the points (0, 0), (0, 1), (0, 2), (1, 2), and (2, 2).

 
      Constraints:

      1 <= side <= 10^9
      4 <= points.length <= min(4 * side, 15 * 10^3)
      points[i] == [xi, yi]
      The input is generated such that:
	
      points[i] lies on the boundary of the square.
      All points[i] are unique.


      4 <= k <= min(25, points.length)

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "2\n[[0, 2], [2, 0], [2, 2], [0, 0]]\n4",
              "2"
          ],
          [
              "2\n[[0, 0], [1, 2], [2, 0], [2, 2], [2, 1]]\n4",
              "1"
          ],
          [
              "2\n[[0, 0], [0, 1], [0, 2], [1, 2], [2, 0], [2, 2], [2, 1]]\n5",
              "1"
          ]
      ]


      def test_lcb():
          for i, (inp, expected) in enumerate(TEST_CASES):
              r = subprocess.run(
                  [sys.executable, "solution.py"],
                  input=inp,
                  capture_output=True,
                  text=True,
                  timeout=10,
              )
              assert r.returncode == 0, f"Case {i}: runtime error\n{r.stderr[:400]}"
              assert r.stdout.strip() == expected.strip(), (
                  f"Case {i}: expected {expected!r}, got {r.stdout!r}"
              )

      """

  Scenario: Agent solves the LiveCodeBench problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
