Feature: LiveCodeBench/leetcode/hard — count-of-sub-multisets-with-bounded-sum
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a 0-indexed array nums of non-negative integers, and two integers l and r.
      Return the count of sub-multisets within nums where the sum of elements in each subset falls within the inclusive range of [l, r].
      Since the answer may be large, return it modulo 10^9 + 7.
      A sub-multiset is an unordered collection of elements of the array in which a given value x can occur 0, 1, ..., occ[x] times, where occ[x] is the number of occurrences of x in the array.
      Note that:

      Two sub-multisets are the same if sorting both sub-multisets results in identical multisets.
      The sum of an empty multiset is 0.

 
      Example 1:

      Input: nums = [1,2,2,3], l = 6, r = 6
      Output: 1
      Explanation: The only subset of nums that has a sum of 6 is {1, 2, 3}.

      Example 2:

      Input: nums = [2,1,4,2,7], l = 1, r = 5
      Output: 7
      Explanation: The subsets of nums that have a sum within the range [1, 5] are {1}, {2}, {4}, {2, 2}, {1, 2}, {1, 4}, and {1, 2, 2}.

      Example 3:

      Input: nums = [1,2,1,3,5,2], l = 3, r = 5
      Output: 9
      Explanation: The subsets of nums that have a sum within the range [3, 5] are {3}, {5}, {1, 2}, {1, 3}, {2, 2}, {2, 3}, {1, 1, 2}, {1, 1, 3}, and {1, 2, 2}.
 
      Constraints:

      1 <= nums.length <= 2 * 10^4
      0 <= nums[i] <= 2 * 10^4
      Sum of nums does not exceed 2 * 10^4.
      0 <= l <= r <= 2 * 10^4

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[1, 2, 2, 3]\n6\n6",
              "1"
          ],
          [
              "[2, 1, 4, 2, 7]\n1\n5",
              "7"
          ],
          [
              "[1, 2, 1, 3, 5, 2]\n3\n5",
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
