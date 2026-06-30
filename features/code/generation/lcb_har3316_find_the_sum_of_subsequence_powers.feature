Feature: LiveCodeBench/leetcode/hard — find-the-sum-of-subsequence-powers
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an integer array nums of length n, and a positive integer k.
      The power of a subsequence is defined as the minimum absolute difference between any two elements in the subsequence.
      Return the sum of powers of all subsequences of nums which have length equal to k.
      Since the answer may be large, return it modulo 10^9 + 7.
 
      Example 1:

      Input: nums = [1,2,3,4], k = 3
      Output: 4
      Explanation:
      There are 4 subsequences in nums which have length 3: [1,2,3], [1,3,4], [1,2,4], and [2,3,4]. The sum of powers is |2 - 3| + |3 - 4| + |2 - 1| + |3 - 4| = 4.

      Example 2:

      Input: nums = [2,2], k = 2
      Output: 0
      Explanation:
      The only subsequence in nums which has length 2 is [2,2]. The sum of powers is |2 - 2| = 0.

      Example 3:

      Input: nums = [4,3,-1], k = 2
      Output: 10
      Explanation:
      There are 3 subsequences in nums which have length 2: [4,3], [4,-1], and [3,-1]. The sum of powers is |4 - 3| + |4 - (-1)| + |3 - (-1)| = 10.

 
      Constraints:

      2 <= n == nums.length <= 50
      -10^8 <= nums[i] <= 10^8 
      2 <= k <= n

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[1, 2, 3, 4]\n3",
              "4"
          ],
          [
              "[2, 2]\n2",
              "0"
          ],
          [
              "[4, 3, -1]\n2",
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
