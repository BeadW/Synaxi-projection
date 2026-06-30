Feature: LiveCodeBench/leetcode/hard — check-if-the-rectangle-corner-is-reachable
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given two positive integers xCorner and yCorner, and a 2D array circles, where circles[i] = [x_i, y_i, r_i] denotes a circle with center at (x_i, y_i) and radius r_i.
      There is a rectangle in the coordinate plane with its bottom left corner at the origin and top right corner at the coordinate (xCorner, yCorner). You need to check whether there is a path from the bottom left corner to the top right corner such that the entire path lies inside the rectangle, does not touch or lie inside any circle, and touches the rectangle only at the two corners.
      Return true if such a path exists, and false otherwise.
 
      Example 1:

      Input: xCorner = 3, yCorner = 4, circles = [[2,1,1]]
      Output: true
      Explanation:

      The black curve shows a possible path between (0, 0) and (3, 4).

      Example 2:

      Input: xCorner = 3, yCorner = 3, circles = [[1,1,2]]
      Output: false
      Explanation:

      No path exists from (0, 0) to (3, 3).

      Example 3:

      Input: xCorner = 3, yCorner = 3, circles = [[2,1,1],[1,2,1]]
      Output: false
      Explanation:

      No path exists from (0, 0) to (3, 3).

      Example 4:

      Input: xCorner = 4, yCorner = 4, circles = [[5,5,1]]
      Output: true
      Explanation:


 
      Constraints:

      3 <= xCorner, yCorner <= 10^9
      1 <= circles.length <= 1000
      circles[i].length == 3
      1 <= x_i, y_i, r_i <= 10^9

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n4\n[[2, 1, 1]]",
              "true"
          ],
          [
              "3\n3\n[[1, 1, 2]]",
              "false"
          ],
          [
              "3\n3\n[[2, 1, 1], [1, 2, 1]]",
              "false"
          ],
          [
              "4\n4\n[[5, 5, 1]]",
              "true"
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
