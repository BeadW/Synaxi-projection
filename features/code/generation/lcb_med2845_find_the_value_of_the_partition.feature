Feature: LiveCodeBench/leetcode/medium — find-the-value-of-the-partition
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a positive integer array nums.
      Partition nums into two arrays, nums1 and nums2, such that:

      Each element of the array nums belongs to either the array nums1 or the array nums2.
      Both arrays are non-empty.
      The value of the partition is minimized.

      The value of the partition is |max(nums1) - min(nums2)|.
      Here, max(nums1) denotes the maximum element of the array nums1, and min(nums2) denotes the minimum element of the array nums2.
      Return the integer denoting the value of such partition.
 
      Example 1:

      Input: nums = [1,3,2,4]
      Output: 1
      Explanation: We can partition the array nums into nums1 = [1,2] and nums2 = [3,4].
      - The maximum element of the array nums1 is equal to 2.
      - The minimum element of the array nums2 is equal to 3.
      The value of the partition is |2 - 3| = 1. 
      It can be proven that 1 is the minimum value out of all partitions.

      Example 2:

      Input: nums = [100,1,10]
      Output: 9
      Explanation: We can partition the array nums into nums1 = [10] and nums2 = [100,1].
      - The maximum element of the array nums1 is equal to 10.
      - The minimum element of the array nums2 is equal to 1.
      The value of the partition is |10 - 1| = 9.
      It can be proven that 9 is the minimum value out of all partitions.

 
      Constraints:

      2 <= nums.length <= 10^5
      1 <= nums[i] <= 10^9

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[1, 3, 2, 4]",
              "1"
          ],
          [
              "[100, 1, 10]",
              "9"
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
