Feature: LiveCodeBench/leetcode/hard — find-the-sum-of-the-power-of-all-subsequences
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an integer array nums of length n and a positive integer k.
      The power of an array of integers is defined as the number of subsequences with their sum equal to k.
      Return the sum of power of all subsequences of nums.
      Since the answer may be very large, return it modulo 10^9 + 7.
 
      Example 1:

      Input:   nums = [1,2,3], k = 3 
      Output:   6 
      Explanation:
      There are 5 subsequences of nums with non-zero power:

      The subsequence [1,2,3] has 2 subsequences with sum == 3: [1,2,3] and [1,2,3].
      The subsequence [1,2,3] has 1 subsequence with sum == 3: [1,2,3].
      The subsequence [1,2,3] has 1 subsequence with sum == 3: [1,2,3].
      The subsequence [1,2,3] has 1 subsequence with sum == 3: [1,2,3].
      The subsequence [1,2,3] has 1 subsequence with sum == 3: [1,2,3].

      Hence the answer is 2 + 1 + 1 + 1 + 1 = 6.

      Example 2:

      Input:   nums = [2,3,3], k = 5 
      Output:   4 
      Explanation:
      There are 3 subsequences of nums with non-zero power:

      The subsequence [2,3,3] has 2 subsequences with sum == 5: [2,3,3] and [2,3,3].
      The subsequence [2,3,3] has 1 subsequence with sum == 5: [2,3,3].
      The subsequence [2,3,3] has 1 subsequence with sum == 5: [2,3,3].

      Hence the answer is 2 + 1 + 1 = 4.

      Example 3:

      Input:   nums = [1,2,3], k = 7 
      Output:   0 
      Explanation: There exists no subsequence with sum 7. Hence all subsequences of nums have power = 0.

 
      Constraints:

      1 <= n <= 100
      1 <= nums[i] <= 10^4
      1 <= k <= 100

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[1, 2, 3]\n3",
              "6"
          ],
          [
              "[2, 3, 3]\n5",
              "4"
          ],
          [
              "[1, 2, 3]\n7",
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
