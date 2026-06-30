Feature: LiveCodeBench/leetcode/medium — ways-to-split-array-into-good-subarrays
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a binary array nums.
      A subarray of an array is good if it contains exactly one element with the value 1.
      Return an integer denoting the number of ways to split the array nums into good subarrays. As the number may be too large, return it modulo 10^9 + 7.
      A subarray is a contiguous non-empty sequence of elements within an array.
 
      Example 1:

      Input: nums = [0,1,0,0,1]
      Output: 3
      Explanation: There are 3 ways to split nums into good subarrays:
      - [0,1] [0,0,1]
      - [0,1,0] [0,1]
      - [0,1,0,0] [1]

      Example 2:

      Input: nums = [0,1,0]
      Output: 1
      Explanation: There is 1 way to split nums into good subarrays:
      - [0,1,0]

 
      Constraints:

      1 <= nums.length <= 10^5
      0 <= nums[i] <= 1

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[0, 1, 0, 0, 1]",
              "3"
          ],
          [
              "[0, 1, 0]",
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
