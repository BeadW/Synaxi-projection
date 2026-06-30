Feature: LiveCodeBench/leetcode/hard — find-subarray-with-bitwise-or-closest-to-k
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an array nums and an integer k. You need to find a subarray of nums such that the absolute difference between k and the bitwise OR of the subarray elements is as small as possible. In other words, select a subarray nums[l..r] such that |k - (nums[l] OR nums[l + 1] ... OR nums[r])| is minimum.
      Return the minimum possible value of the absolute difference.
      A subarray is a contiguous non-empty sequence of elements within an array.
 
      Example 1:

      Input: nums = [1,2,4,5], k = 3
      Output: 0
      Explanation:
      The subarray nums[0..1] has OR value 3, which gives the minimum absolute difference |3 - 3| = 0.

      Example 2:

      Input: nums = [1,3,1,3], k = 2
      Output: 1
      Explanation:
      The subarray nums[1..1] has OR value 3, which gives the minimum absolute difference |3 - 2| = 1.

      Example 3:

      Input: nums = [1], k = 10
      Output: 9
      Explanation:
      There is a single subarray with OR value 1, which gives the minimum absolute difference |10 - 1| = 9.

 
      Constraints:

      1 <= nums.length <= 10^5
      1 <= nums[i] <= 10^9
      1 <= k <= 10^9

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[1, 2, 4, 5]\n3",
              "0"
          ],
          [
              "[1, 3, 1, 3]\n2",
              "1"
          ],
          [
              "[1]\n10",
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
