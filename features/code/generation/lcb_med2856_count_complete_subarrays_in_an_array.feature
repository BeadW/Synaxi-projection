Feature: LiveCodeBench/leetcode/medium — count-complete-subarrays-in-an-array
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an array nums consisting of positive integers.
      We call a subarray of an array complete if the following condition is satisfied:

      The number of distinct elements in the subarray is equal to the number of distinct elements in the whole array.

      Return the number of complete subarrays.
      A subarray is a contiguous non-empty part of an array.
 
      Example 1:

      Input: nums = [1,3,1,2,2]
      Output: 4
      Explanation: The complete subarrays are the following: [1,3,1,2], [1,3,1,2,2], [3,1,2] and [3,1,2,2].

      Example 2:

      Input: nums = [5,5,5,5]
      Output: 10
      Explanation: The array consists only of the integer 5, so any subarray is complete. The number of subarrays that we can choose is 10.

 
      Constraints:

      1 <= nums.length <= 1000
      1 <= nums[i] <= 2000

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[1, 3, 1, 2, 2]",
              "4"
          ],
          [
              "[5, 5, 5, 5]",
              "10"
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
