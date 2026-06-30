Feature: LiveCodeBench/leetcode/medium — count-subarrays-where-max-element-appears-at-least-k-times
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an integer array nums and a positive integer k.
      Return the number of subarrays where the maximum element of nums appears at least k times in that subarray.
      A subarray is a contiguous sequence of elements within an array.
 
      Example 1:

      Input: nums = [1,3,2,3,3], k = 2
      Output: 6
      Explanation: The subarrays that contain the element 3 at least 2 times are: [1,3,2,3], [1,3,2,3,3], [3,2,3], [3,2,3,3], [2,3,3] and [3,3].

      Example 2:

      Input: nums = [1,4,2,1], k = 3
      Output: 0
      Explanation: No subarray contains the element 4 at least 3 times.

 
      Constraints:

      1 <= nums.length <= 10^5
      1 <= nums[i] <= 10^6
      1 <= k <= 10^5

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[1, 3, 2, 3, 3]\n2",
              "6"
          ],
          [
              "[1, 4, 2, 1]\n3",
              "0"
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
