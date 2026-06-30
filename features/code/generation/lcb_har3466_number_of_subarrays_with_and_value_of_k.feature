Feature: LiveCodeBench/leetcode/hard — number-of-subarrays-with-and-value-of-k
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Given an array of integers nums and an integer k, return the number of subarrays of nums where the bitwise AND of the elements of the subarray equals k.
 
      Example 1:

      Input: nums = [1,1,1], k = 1
      Output: 6
      Explanation:
      All subarrays contain only 1's.

      Example 2:

      Input: nums = [1,1,2], k = 1
      Output: 3
      Explanation:
      Subarrays having an AND value of 1 are: [1,1,2], [1,1,2], [1,1,2].

      Example 3:

      Input: nums = [1,2,3], k = 2
      Output: 2
      Explanation:
      Subarrays having an AND value of 2 are: [1,2,3], [1,2,3].

 
      Constraints:

      1 <= nums.length <= 10^5
      0 <= nums[i], k <= 10^9

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[1, 1, 1]\n1",
              "6"
          ],
          [
              "[1, 1, 2]\n1",
              "3"
          ],
          [
              "[1, 2, 3]\n2",
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
