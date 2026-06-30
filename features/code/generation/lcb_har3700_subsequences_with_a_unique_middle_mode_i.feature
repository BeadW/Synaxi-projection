Feature: LiveCodeBench/leetcode/hard — subsequences-with-a-unique-middle-mode-i
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Given an integer array nums, find the number of subsequences of size 5 of nums with a unique middle mode.
      Since the answer may be very large, return it modulo 10^9 + 7.
      A mode of a sequence of numbers is defined as the element that appears the maximum number of times in the sequence.
      A sequence of numbers contains a unique mode if it has only one mode.
      A sequence of numbers seq of size 5 contains a unique middle mode if the middle element (seq[2]) is a unique mode.
 
      Example 1:

      Input: nums = [1,1,1,1,1,1]
      Output: 6
      Explanation:
      [1, 1, 1, 1, 1] is the only subsequence of size 5 that can be formed, and it has a unique middle mode of 1. This subsequence can be formed in 6 different ways, so the output is 6. 

      Example 2:

      Input: nums = [1,2,2,3,3,4]
      Output: 4
      Explanation:
      [1, 2, 2, 3, 4] and [1, 2, 3, 3, 4] each have a unique middle mode because the number at index 2 has the greatest frequency in the subsequence. [1, 2, 2, 3, 3] does not have a unique middle mode because 2 and 3 appear twice.

      Example 3:

      Input: nums = [0,1,2,3,4,5,6,7,8]
      Output: 0
      Explanation:
      There is no subsequence of length 5 with a unique middle mode.

 
      Constraints:

      5 <= nums.length <= 1000
      -10^9 <= nums[i] <= 10^9

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[1, 1, 1, 1, 1, 1]",
              "6"
          ],
          [
              "[1, 2, 2, 3, 3, 4]",
              "4"
          ],
          [
              "[0, 1, 2, 3, 4, 5, 6, 7, 8]",
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
