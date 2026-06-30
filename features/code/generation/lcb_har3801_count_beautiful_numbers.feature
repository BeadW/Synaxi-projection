Feature: LiveCodeBench/leetcode/hard — count-beautiful-numbers
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given two positive integers, l and r. A positive integer is called beautiful if the product of its digits is divisible by the sum of its digits.
      Return the count of beautiful numbers between l and r, inclusive.
 
      Example 1:

      Input: l = 10, r = 20
      Output: 2
      Explanation:
      The beautiful numbers in the range are 10 and 20.

      Example 2:

      Input: l = 1, r = 15
      Output: 10
      Explanation:
      The beautiful numbers in the range are 1, 2, 3, 4, 5, 6, 7, 8, 9, and 10.

 
      Constraints:

      1 <= l <= r < 10^9

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "10\n20",
              "2"
          ],
          [
              "1\n15",
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
