Feature: LiveCodeBench/leetcode/medium — determine-the-minimum-sum-of-a-k-avoiding-array
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given two integers, n and k.
      An array of distinct positive integers is called a k-avoiding array if there does not exist any pair of distinct elements that sum to k.
      Return the minimum possible sum of a k-avoiding array of length n.
 
      Example 1:

      Input: n = 5, k = 4
      Output: 18
      Explanation: Consider the k-avoiding array [1,2,4,5,6], which has a sum of 18.
      It can be proven that there is no k-avoiding array with a sum less than 18.

      Example 2:

      Input: n = 2, k = 6
      Output: 3
      Explanation: We can construct the array [1,2], which has a sum of 3.
      It can be proven that there is no k-avoiding array with a sum less than 3.

 
      Constraints:

      1 <= n, k <= 50

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5\n4",
              "18"
          ],
          [
              "2\n6",
              "3"
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
