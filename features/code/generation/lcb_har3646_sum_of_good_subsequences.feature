Feature: LiveCodeBench/leetcode/hard — sum-of-good-subsequences
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an integer array nums. A good subsequence is defined as a subsequence of nums where the absolute difference between any two consecutive elements in the subsequence is exactly 1.
      Return the sum of all possible good subsequences of nums.
      Since the answer may be very large, return it modulo 10^9 + 7.
      Note that a subsequence of size 1 is considered good by definition.
 
      Example 1:

      Input: nums = [1,2,1]
      Output: 14
      Explanation:

      Good subsequences are: [1], [2], [1], [1,2], [2,1], [1,2,1].
      The sum of elements in these subsequences is 14.


      Example 2:

      Input: nums = [3,4,5]
      Output: 40
      Explanation:

      Good subsequences are: [3], [4], [5], [3,4], [4,5], [3,4,5].
      The sum of elements in these subsequences is 40.


 
      Constraints:

      1 <= nums.length <= 10^5
      0 <= nums[i] <= 10^5

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[1, 2, 1]",
              "14"
          ],
          [
              "[3, 4, 5]",
              "40"
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
