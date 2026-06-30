Feature: LiveCodeBench/leetcode/hard — find-the-largest-palindrome-divisible-by-k
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

      Return the largest integer having n digits (as a string) that is k-palindromic.
      Note that the integer must not have leading zeros.
 
      Example 1:

      Input: n = 3, k = 5
      Output: "595"
      Explanation:
      595 is the largest k-palindromic integer with 3 digits.

      Example 2:

      Input: n = 1, k = 4
      Output: "8"
      Explanation:
      4 and 8 are the only k-palindromic integers with 1 digit.

      Example 3:

      Input: n = 5, k = 6
      Output: "89898"

 
      Constraints:

      1 <= n <= 10^5
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
              "\"595\""
          ],
          [
              "1\n4",
              "\"8\""
          ],
          [
              "5\n6",
              "\"89898\""
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
