Feature: LiveCodeBench/leetcode/hard — select-cells-in-grid-with-maximum-score
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a 2D matrix grid consisting of positive integers.
      You have to select one or more cells from the matrix such that the following conditions are satisfied:

      No two selected cells are in the same row of the matrix.
      The values in the set of selected cells are unique.

      Your score will be the sum of the values of the selected cells.
      Return the maximum score you can achieve.
 
      Example 1:

      Input: grid = [[1,2,3],[4,3,2],[1,1,1]]
      Output: 8
      Explanation:

      We can select the cells with values 1, 3, and 4 that are colored above.

      Example 2:

      Input: grid = [[8,7,6],[8,3,2]]
      Output: 15
      Explanation:

      We can select the cells with values 7 and 8 that are colored above.

 
      Constraints:

      1 <= grid.length, grid[i].length <= 10
      1 <= grid[i][j] <= 100

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[[1, 2, 3], [4, 3, 2], [1, 1, 1]]",
              "8"
          ],
          [
              "[[8, 7, 6], [8, 3, 2]]",
              "15"
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
