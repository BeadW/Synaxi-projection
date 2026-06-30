Feature: LiveCodeBench/leetcode/hard — count-the-number-of-inversions
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an integer n and a 2D array requirements, where requirements[i] = [end_i, cnt_i] represents the end index and the inversion count of each requirement.
      A pair of indices (i, j) from an integer array nums is called an inversion if:

      i < j and nums[i] > nums[j]

      Return the number of permutations perm of [0, 1, 2, ..., n - 1] such that for all requirements[i], perm[0..end_i] has exactly cnt_i inversions.
      Since the answer may be very large, return it modulo 10^9 + 7.
 
      Example 1:

      Input: n = 3, requirements = [[2,2],[0,0]]
      Output: 2
      Explanation:
      The two permutations are:

      [2, 0, 1]

      Prefix [2, 0, 1] has inversions (0, 1) and (0, 2).
      Prefix [2] has 0 inversions.


      [1, 2, 0]

      Prefix [1, 2, 0] has inversions (0, 2) and (1, 2).
      Prefix [1] has 0 inversions.




      Example 2:

      Input: n = 3, requirements = [[2,2],[1,1],[0,0]]
      Output: 1
      Explanation:
      The only satisfying permutation is [2, 0, 1]:

      Prefix [2, 0, 1] has inversions (0, 1) and (0, 2).
      Prefix [2, 0] has an inversion (0, 1).
      Prefix [2] has 0 inversions.


      Example 3:

      Input: n = 2, requirements = [[0,0],[1,0]]
      Output: 1
      Explanation:
      The only satisfying permutation is [0, 1]:

      Prefix [0] has 0 inversions.
      Prefix [0, 1] has an inversion (0, 1).


 
      Constraints:

      2 <= n <= 300
      1 <= requirements.length <= n
      requirements[i] = [end_i, cnt_i]
      0 <= end_i <= n - 1
      0 <= cnt_i <= 400
      The input is generated such that there is at least one i such that end_i == n - 1.
      The input is generated such that all end_i are unique.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n[[2, 2], [0, 0]]",
              "2"
          ],
          [
              "3\n[[2, 2], [1, 1], [0, 0]]",
              "1"
          ],
          [
              "2\n[[0, 0], [1, 0]]",
              "1"
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
