Feature: LiveCodeBench/leetcode/hard — minimum-cost-to-equalize-array
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an integer array nums and two integers cost1 and cost2. You are allowed to perform either of the following operations any number of times:

      Choose an index i from nums and increase nums[i] by 1 for a cost of cost1.
      Choose two different indices i, j, from nums and increase nums[i] and nums[j] by 1 for a cost of cost2.

      Return the minimum cost required to make all elements in the array equal. 
      Since the answer may be very large, return it modulo 10^9 + 7.
 
      Example 1:

      Input: nums = [4,1], cost1 = 5, cost2 = 2
      Output: 15
      Explanation: 
      The following operations can be performed to make the values equal:

      Increase nums[1] by 1 for a cost of 5. nums becomes [4,2].
      Increase nums[1] by 1 for a cost of 5. nums becomes [4,3].
      Increase nums[1] by 1 for a cost of 5. nums becomes [4,4].

      The total cost is 15.

      Example 2:

      Input: nums = [2,3,3,3,5], cost1 = 2, cost2 = 1
      Output: 6
      Explanation: 
      The following operations can be performed to make the values equal:

      Increase nums[0] and nums[1] by 1 for a cost of 1. nums becomes [3,4,3,3,5].
      Increase nums[0] and nums[2] by 1 for a cost of 1. nums becomes [4,4,4,3,5].
      Increase nums[0] and nums[3] by 1 for a cost of 1. nums becomes [5,4,4,4,5].
      Increase nums[1] and nums[2] by 1 for a cost of 1. nums becomes [5,5,5,4,5].
      Increase nums[3] by 1 for a cost of 2. nums becomes [5,5,5,5,5].

      The total cost is 6.

      Example 3:

      Input: nums = [3,5,3], cost1 = 1, cost2 = 3
      Output: 4
      Explanation:
      The following operations can be performed to make the values equal:

      Increase nums[0] by 1 for a cost of 1. nums becomes [4,5,3].
      Increase nums[0] by 1 for a cost of 1. nums becomes [5,5,3].
      Increase nums[2] by 1 for a cost of 1. nums becomes [5,5,4].
      Increase nums[2] by 1 for a cost of 1. nums becomes [5,5,5].

      The total cost is 4.

 
      Constraints:

      1 <= nums.length <= 10^5
      1 <= nums[i] <= 10^6
      1 <= cost1 <= 10^6
      1 <= cost2 <= 10^6

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[4, 1]\n5\n2",
              "15"
          ],
          [
              "[2, 3, 3, 3, 5]\n2\n1",
              "6"
          ],
          [
              "[3, 5, 3]\n1\n3",
              "4"
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
