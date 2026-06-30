Feature: LiveCodeBench/leetcode/hard — find-the-occurrence-of-first-almost-equal-substring
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given two strings s and pattern.
      A string x is called almost equal to y if you can change at most one character in x to make it identical to y.
      Return the smallest starting index of a substring in s that is almost equal to pattern. If no such index exists, return -1.
      A substring is a contiguous non-empty sequence of characters within a string.
 
      Example 1:

      Input: s = "abcdefg", pattern = "bcdffg"
      Output: 1
      Explanation:
      The substring s[1..6] == "bcdefg" can be converted to "bcdffg" by changing s[4] to "f".

      Example 2:

      Input: s = "ababbababa", pattern = "bacaba"
      Output: 4
      Explanation:
      The substring s[4..9] == "bababa" can be converted to "bacaba" by changing s[6] to "c".

      Example 3:

      Input: s = "abcd", pattern = "dba"
      Output: -1

      Example 4:

      Input: s = "dde", pattern = "d"
      Output: 0

 
      Constraints:

      1 <= pattern.length < s.length <= 10^5
      s and pattern consist only of lowercase English letters.

 
      Follow-up: Could you solve the problem if at most k consecutive characters can be changed?

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "\"abcdefg\"\n\"bcdffg\"",
              "1"
          ],
          [
              "\"ababbababa\"\n\"bacaba\"",
              "4"
          ],
          [
              "\"abcd\"\n\"dba\"",
              "-1"
          ],
          [
              "\"dde\"\n\"d\"",
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
