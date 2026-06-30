Feature: LiveCodeBench/leetcode/hard — minimum-increments-for-target-multiples-in-an-array
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given two arrays, nums and target.
      In a single operation, you may increment any element of nums by 1.
      Return the minimum number of operations required so that each element in target has at least one multiple in nums.
 
      Example 1:

      Input: nums = [1,2,3], target = [4]
      Output: 1
      Explanation:
      The minimum number of operations required to satisfy the condition is 1.

      Increment 3 to 4 with just one operation, making 4 a multiple of itself.


      Example 2:

      Input: nums = [8,4], target = [10,5]
      Output: 2
      Explanation:
      The minimum number of operations required to satisfy the condition is 2.

      Increment 8 to 10 with 2 operations, making 10 a multiple of both 5 and 10.


      Example 3:

      Input: nums = [7,9,10], target = [7]
      Output: 0
      Explanation:
      Target 7 already has a multiple in nums, so no additional operations are needed.

 
      Constraints:

      1 <= nums.length <= 5 * 10^4
      1 <= target.length <= 4
      target.length <= nums.length
      1 <= nums[i], target[i] <= 10^4

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[1, 2, 3]\n[4]",
              "1"
          ],
          [
              "[8, 4]\n[10, 5]",
              "2"
          ],
          [
              "[7, 9, 10]\n[7]",
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
