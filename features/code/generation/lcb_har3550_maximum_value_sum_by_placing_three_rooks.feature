Feature: LiveCodeBench/leetcode/hard — maximum-value-sum-by-placing-three-rooks-i
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a m x n 2D array board representing a chessboard, where board[i][j] represents the value of the cell (i, j).
      Rooks in the same row or column attack each other. You need to place three rooks on the chessboard such that the rooks do not attack each other.
      Return the maximum sum of the cell values on which the rooks are placed.
 
      Example 1:

      Input: board = [[-3,1,1,1],[-3,1,-3,1],[-3,2,1,1]]
      Output: 4
      Explanation:

      We can place the rooks in the cells (0, 2), (1, 3), and (2, 1) for a sum of 1 + 1 + 2 = 4.

      Example 2:

      Input: board = [[1,2,3],[4,5,6],[7,8,9]]
      Output: 15
      Explanation:
      We can place the rooks in the cells (0, 0), (1, 1), and (2, 2) for a sum of 1 + 5 + 9 = 15.

      Example 3:

      Input: board = [[1,1,1],[1,1,1],[1,1,1]]
      Output: 3
      Explanation:
      We can place the rooks in the cells (0, 2), (1, 1), and (2, 0) for a sum of 1 + 1 + 1 = 3.

 
      Constraints:

      3 <= m == board.length <= 100
      3 <= n == board[i].length <= 100
      -10^9 <= board[i][j] <= 10^9

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[[-3, 1, 1, 1], [-3, 1, -3, 1], [-3, 2, 1, 1]]",
              "4"
          ],
          [
              "[[1, 2, 3], [4, 5, 6], [7, 8, 9]]",
              "15"
          ],
          [
              "[[1, 1, 1], [1, 1, 1], [1, 1, 1]]",
              "3"
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
