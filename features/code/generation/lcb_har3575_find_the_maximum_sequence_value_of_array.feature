Feature: LiveCodeBench/leetcode/hard — find-the-maximum-sequence-value-of-array
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an integer array nums and a positive integer k.
      The value of a sequence seq of size 2 * x is defined as:

      (seq[0] OR seq[1] OR ... OR seq[x - 1]) XOR (seq[x] OR seq[x + 1] OR ... OR seq[2 * x - 1]).

      Return the maximum value of any subsequence of nums having size 2 * k.
 
      Example 1:

      Input: nums = [2,6,7], k = 1
      Output: 5
      Explanation:
      The subsequence [2, 7] has the maximum value of 2 XOR 7 = 5.

      Example 2:

      Input: nums = [4,2,5,6,7], k = 2
      Output: 2
      Explanation:
      The subsequence [4, 5, 6, 7] has the maximum value of (4 OR 5) XOR (6 OR 7) = 2.

 
      Constraints:

      2 <= nums.length <= 400
      1 <= nums[i] < 2^7
      1 <= k <= nums.length / 2

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[2, 6, 7]\n1",
              "5"
          ],
          [
              "[4, 2, 5, 6, 7]\n2",
              "2"
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
