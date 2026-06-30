Feature: LiveCodeBench/leetcode/hard — maximum-and-minimum-sums-of-at-most-size-k-subarrays
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an integer array nums and a positive integer k. Return the sum of the maximum and minimum elements of all subarrays with at most k elements.
 
      Example 1:

      Input: nums = [1,2,3], k = 2
      Output: 20
      Explanation:
      The subarrays of nums with at most 2 elements are:



      Subarray
      Minimum
      Maximum
      Sum


      [1]
      1
      1
      2


      [2]
      2
      2
      4


      [3]
      3
      3
      6


      [1, 2]
      1
      2
      3


      [2, 3]
      2
      3
      5


      Final Total
 
 
      20



      The output would be 20.

      Example 2:

      Input: nums = [1,-3,1], k = 2
      Output: -6
      Explanation:
      The subarrays of nums with at most 2 elements are:



      Subarray
      Minimum
      Maximum
      Sum


      [1]
      1
      1
      2


      [-3]
      -3
      -3
      -6


      [1]
      1
      1
      2


      [1, -3]
      -3
      1
      -2


      [-3, 1]
      -3
      1
      -2


      Final Total
 
 
      -6



      The output would be -6.

 
      Constraints:

      1 <= nums.length <= 80000
      1 <= k <= nums.length
      -10^6 <= nums[i] <= 10^6

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[1, 2, 3]\n2",
              "20"
          ],
          [
              "[1, -3, 1]\n2",
              "-6"
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
