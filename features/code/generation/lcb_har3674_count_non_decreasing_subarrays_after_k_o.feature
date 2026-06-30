Feature: LiveCodeBench/leetcode/hard — count-non-decreasing-subarrays-after-k-operations
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an array nums of n integers and an integer k.
      For each subarray of nums, you can apply up to k operations on it. In each operation, you increment any element of the subarray by 1.
      Note that each subarray is considered independently, meaning changes made to one subarray do not persist to another.
      Return the number of subarrays that you can make non-decreasing ​​​​​after performing at most k operations.
      An array is said to be non-decreasing if each element is greater than or equal to its previous element, if it exists.
 
      Example 1:

      Input: nums = [6,3,1,2,4,4], k = 7
      Output: 17
      Explanation:
      Out of all 21 possible subarrays of nums, only the subarrays [6, 3, 1], [6, 3, 1, 2], [6, 3, 1, 2, 4] and [6, 3, 1, 2, 4, 4] cannot be made non-decreasing after applying up to k = 7 operations. Thus, the number of non-decreasing subarrays is 21 - 4 = 17.

      Example 2:

      Input: nums = [6,3,1,3,6], k = 4
      Output: 12
      Explanation:
      The subarray [3, 1, 3, 6] along with all subarrays of nums with three or fewer elements, except [6, 3, 1], can be made non-decreasing after k operations. There are 5 subarrays of a single element, 4 subarrays of two elements, and 2 subarrays of three elements except [6, 3, 1], so there are 1 + 5 + 4 + 2 = 12 subarrays that can be made non-decreasing.

 
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
              "[6, 3, 1, 2, 4, 4]\n7",
              "17"
          ],
          [
              "[6, 3, 1, 3, 6]\n4",
              "12"
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
