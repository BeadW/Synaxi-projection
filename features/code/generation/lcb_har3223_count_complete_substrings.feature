Feature: LiveCodeBench/leetcode/hard — count-complete-substrings
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a string word and an integer k.
      A substring s of word is complete if:

      Each character in s occurs exactly k times.
      The difference between two adjacent characters is at most 2. That is, for any two adjacent characters c1 and c2 in s, the absolute difference in their positions in the alphabet is at most 2.

      Return the number of complete substrings of word.
      A substring is a non-empty contiguous sequence of characters in a string.
 
      Example 1:

      Input: word = "igigee", k = 2
      Output: 3
      Explanation: The complete substrings where each character appears exactly twice and the difference between adjacent characters is at most 2 are: igigee, igigee, igigee.

      Example 2:

      Input: word = "aaabbbccc", k = 3
      Output: 6
      Explanation: The complete substrings where each character appears exactly three times and the difference between adjacent characters is at most 2 are: aaabbbccc, aaabbbccc, aaabbbccc, aaabbbccc, aaabbbccc, aaabbbccc.

 
      Constraints:

      1 <= word.length <= 10^5
      word consists only of lowercase English letters.
      1 <= k <= word.length

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "\"igigee\"\n2",
              "3"
          ],
          [
              "\"aaabbbccc\"\n3",
              "6"
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
