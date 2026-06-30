Feature: LiveCodeBench/leetcode/hard — minimize-the-maximum-adjacent-element-difference
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an array of integers nums. Some values in nums are missing and are denoted by -1.
      You can choose a pair of positive integers (x, y) exactly once and replace each missing element with either x or y.
      You need to minimize the maximum absolute difference between adjacent elements of nums after replacements.
      Return the minimum possible difference.
 
      Example 1:

      Input: nums = [1,2,-1,10,8]
      Output: 4
      Explanation:
      By choosing the pair as (6, 7), nums can be changed to [1, 2, 6, 10, 8].
      The absolute differences between adjacent elements are:

      |1 - 2| == 1
      |2 - 6| == 4
      |6 - 10| == 4
      |10 - 8| == 2


      Example 2:

      Input: nums = [-1,-1,-1]
      Output: 0
      Explanation:
      By choosing the pair as (4, 4), nums can be changed to [4, 4, 4].

      Example 3:

      Input: nums = [-1,10,-1,8]
      Output: 1
      Explanation:
      By choosing the pair as (11, 9), nums can be changed to [11, 10, 9, 8].

 
      Constraints:

      2 <= nums.length <= 10^5
      nums[i] is either -1 or in the range [1, 10^9].

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[1, 2, -1, 10, 8]",
              "4"
          ],
          [
              "[-1, -1, -1]",
              "0"
          ],
          [
              "[-1, 10, -1, 8]",
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
