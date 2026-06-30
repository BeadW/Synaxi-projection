Feature: LiveCodeBench/leetcode/hard — find-the-count-of-good-integers
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given two positive integers n and k.
      An integer x is called k-palindromic if:

      x is a palindrome.
      x is divisible by k.

      An integer is called good if its digits can be rearranged to form a k-palindromic integer. For example, for k = 2, 2020 can be rearranged to form the k-palindromic integer 2002, whereas 1010 cannot be rearranged to form a k-palindromic integer.
      Return the count of good integers containing n digits.
      Note that any integer must not have leading zeros, neither before nor after rearrangement. For example, 1010 cannot be rearranged to form 101.
 
      Example 1:

      Input: n = 3, k = 5
      Output: 27
      Explanation:
      Some of the good integers are:

      551 because it can be rearranged to form 515.
      525 because it is already k-palindromic.


      Example 2:

      Input: n = 1, k = 4
      Output: 2
      Explanation:
      The two good integers are 4 and 8.

      Example 3:

      Input: n = 5, k = 6
      Output: 2468

 
      Constraints:

      1 <= n <= 10
      1 <= k <= 9

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n5",
              "27"
          ],
          [
              "1\n4",
              "2"
          ],
          [
              "5\n6",
              "2468"
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
