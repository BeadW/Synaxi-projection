Feature: LiveCodeBench/leetcode/hard — maximum-score-of-non-overlapping-intervals
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a 2D integer array intervals, where intervals[i] = [l_i, r_i, weight_i]. Interval i starts at position l_i and ends at r_i, and has a weight of weight_i. You can choose up to 4 non-overlapping intervals. The score of the chosen intervals is defined as the total sum of their weights.
      Return the lexicographically smallest array of at most 4 indices from intervals with maximum score, representing your choice of non-overlapping intervals.
      Two intervals are said to be non-overlapping if they do not share any points. In particular, intervals sharing a left or right boundary are considered overlapping.
      An array a is lexicographically smaller than an array b if in the first position where a and b differ, array a has an element that is less than the corresponding element in b.
      If the first min(a.length, b.length) elements do not differ, then the shorter array is the lexicographically smaller one.
 
      Example 1:

      Input: intervals = [[1,3,2],[4,5,2],[1,5,5],[6,9,3],[6,7,1],[8,9,1]]
      Output: [2,3]
      Explanation:
      You can choose the intervals with indices 2, and 3 with respective weights of 5, and 3.

      Example 2:

      Input: intervals = [[5,8,1],[6,7,7],[4,7,3],[9,10,6],[7,8,2],[11,14,3],[3,5,5]]
      Output: [1,3,5,6]
      Explanation:
      You can choose the intervals with indices 1, 3, 5, and 6 with respective weights of 7, 6, 3, and 5.

 
      Constraints:

      1 <= intevals.length <= 5 * 10^4
      intervals[i].length == 3
      intervals[i] = [l_i, r_i, weight_i]
      1 <= l_i <= r_i <= 10^9
      1 <= weight_i <= 10^9

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[[1, 3, 2], [4, 5, 2], [1, 5, 5], [6, 9, 3], [6, 7, 1], [8, 9, 1]]",
              "[2, 3]"
          ],
          [
              "[[5, 8, 1], [6, 7, 7], [4, 7, 3], [9, 10, 6], [7, 8, 2], [11, 14, 3], [3, 5, 5]]",
              "[1, 3, 5, 6]"
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
