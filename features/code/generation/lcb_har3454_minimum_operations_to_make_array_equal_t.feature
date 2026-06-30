Feature: LiveCodeBench/leetcode/hard — minimum-operations-to-make-array-equal-to-target
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given two positive integer arrays nums and target, of the same length.
      In a single operation, you can select any subarray of nums and increment or decrement each element within that subarray by 1.
      Return the minimum number of operations required to make nums equal to the array target.
 
      Example 1:

      Input: nums = [3,5,1,2], target = [4,6,2,4]
      Output: 2
      Explanation:
      We will perform the following operations to make nums equal to target:
      - Increment nums[0..3] by 1, nums = [4,6,2,3].
      - Increment nums[3..3] by 1, nums = [4,6,2,4].

      Example 2:

      Input: nums = [1,3,2], target = [2,1,4]
      Output: 5
      Explanation:
      We will perform the following operations to make nums equal to target:
      - Increment nums[0..0] by 1, nums = [2,3,2].
      - Decrement nums[1..1] by 1, nums = [2,2,2].
      - Decrement nums[1..1] by 1, nums = [2,1,2].
      - Increment nums[2..2] by 1, nums = [2,1,3].
      - Increment nums[2..2] by 1, nums = [2,1,4].

 
      Constraints:

      1 <= nums.length == target.length <= 10^5
      1 <= nums[i], target[i] <= 10^8

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[3, 5, 1, 2]\n[4, 6, 2, 4]",
              "2"
          ],
          [
              "[1, 3, 2]\n[2, 1, 4]",
              "5"
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
