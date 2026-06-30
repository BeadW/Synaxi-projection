Feature: LiveCodeBench/leetcode/hard — count-the-number-of-good-partitions
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a 0-indexed array nums consisting of positive integers.
      A partition of an array into one or more contiguous subarrays is called good if no two subarrays contain the same number.
      Return the total number of good partitions of nums.
      Since the answer may be large, return it modulo 10^9 + 7.
 
      Example 1:

      Input: nums = [1,2,3,4]
      Output: 8
      Explanation: The 8 possible good partitions are: ([1], [2], [3], [4]), ([1], [2], [3,4]), ([1], [2,3], [4]), ([1], [2,3,4]), ([1,2], [3], [4]), ([1,2], [3,4]), ([1,2,3], [4]), and ([1,2,3,4]).

      Example 2:

      Input: nums = [1,1,1,1]
      Output: 1
      Explanation: The only possible good partition is: ([1,1,1,1]).

      Example 3:

      Input: nums = [1,2,1,3]
      Output: 2
      Explanation: The 2 possible good partitions are: ([1,2,1], [3]) and ([1,2,1,3]).

 
      Constraints:

      1 <= nums.length <= 10^5
      1 <= nums[i] <= 10^9

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[1, 2, 3, 4]",
              "8"
          ],
          [
              "[1, 1, 1, 1]",
              "1"
          ],
          [
              "[1, 2, 1, 3]",
              "2"
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
