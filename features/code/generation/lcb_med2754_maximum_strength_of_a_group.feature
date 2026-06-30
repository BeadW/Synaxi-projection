Feature: LiveCodeBench/leetcode/medium — maximum-strength-of-a-group
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a 0-indexed integer array nums representing the score of students in an exam. The teacher would like to form one non-empty group of students with maximal strength, where the strength of a group of students of indices i_0, i_1, i_2, ... , i_k is defined as nums[i_0] * nums[i_1] * nums[i_2] * ... * nums[i_k​].
      Return the maximum strength of a group the teacher can create.
 
      Example 1:

      Input: nums = [3,-1,-5,2,5,-9]
      Output: 1350
      Explanation: One way to form a group of maximal strength is to group the students at indices [0,2,3,4,5]. Their strength is 3 * (-5) * 2 * 5 * (-9) = 1350, which we can show is optimal.

      Example 2:

      Input: nums = [-4,-5,-4]
      Output: 20
      Explanation: Group the students at indices [0, 1] . Then, we’ll have a resulting strength of 20. We cannot achieve greater strength.

 
      Constraints:

      1 <= nums.length <= 13
      -9 <= nums[i] <= 9

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[3, -1, -5, 2, 5, -9]",
              "1350"
          ],
          [
              "[-4, -5, -4]",
              "20"
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
