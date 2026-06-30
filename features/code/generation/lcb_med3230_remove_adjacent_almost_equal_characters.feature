Feature: LiveCodeBench/leetcode/medium — remove-adjacent-almost-equal-characters
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a 0-indexed string word.
      In one operation, you can pick any index i of word and change word[i] to any lowercase English letter.
      Return the minimum number of operations needed to remove all adjacent almost-equal characters from word.
      Two characters a and b are almost-equal if a == b or a and b are adjacent in the alphabet.
 
      Example 1:

      Input: word = "aaaaa"
      Output: 2
      Explanation: We can change word into "acaca" which does not have any adjacent almost-equal characters.
      It can be shown that the minimum number of operations needed to remove all adjacent almost-equal characters from word is 2.

      Example 2:

      Input: word = "abddez"
      Output: 2
      Explanation: We can change word into "ybdoez" which does not have any adjacent almost-equal characters.
      It can be shown that the minimum number of operations needed to remove all adjacent almost-equal characters from word is 2.
      Example 3:

      Input: word = "zyxyxyz"
      Output: 3
      Explanation: We can change word into "zaxaxaz" which does not have any adjacent almost-equal characters. 
      It can be shown that the minimum number of operations needed to remove all adjacent almost-equal characters from word is 3.

 
      Constraints:

      1 <= word.length <= 100
      word consists only of lowercase English letters.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "\"aaaaa\"",
              "2"
          ],
          [
              "\"abddez\"",
              "2"
          ],
          [
              "\"zyxyxyz\"",
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
