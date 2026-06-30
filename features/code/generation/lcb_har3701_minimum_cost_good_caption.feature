Feature: LiveCodeBench/leetcode/hard — minimum-cost-good-caption
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a string caption of length n. A good caption is a string where every character appears in groups of at least 3 consecutive occurrences.
      For example:

      "aaabbb" and "aaaaccc" are good captions.
      "aabbb" and "ccccd" are not good captions.

      You can perform the following operation any number of times:
      Choose an index i (where 0 <= i < n) and change the character at that index to either:

      The character immediately before it in the alphabet (if caption[i] != 'a').
      The character immediately after it in the alphabet (if caption[i] != 'z').

      Your task is to convert the given caption into a good caption using the minimum number of operations, and return it. If there are multiple possible good captions, return the lexicographically smallest one among them. If it is impossible to create a good caption, return an empty string "".
 
      Example 1:

      Input: caption = "cdcd"
      Output: "cccc"
      Explanation:
      It can be shown that the given caption cannot be transformed into a good caption with fewer than 2 operations. The possible good captions that can be created using exactly 2 operations are:

      "dddd": Change caption[0] and caption[2] to their next character 'd'.
      "cccc": Change caption[1] and caption[3] to their previous character 'c'.

      Since "cccc" is lexicographically smaller than "dddd", return "cccc".

      Example 2:

      Input: caption = "aca"
      Output: "aaa"
      Explanation:
      It can be proven that the given caption requires at least 2 operations to be transformed into a good caption. The only good caption that can be obtained with exactly 2 operations is as follows:

      Operation 1: Change caption[1] to 'b'. caption = "aba".
      Operation 2: Change caption[1] to 'a'. caption = "aaa".

      Thus, return "aaa".

      Example 3:

      Input: caption = "bc"
      Output: ""
      Explanation:
      It can be shown that the given caption cannot be converted to a good caption by using any number of operations.

 
      Constraints:

      1 <= caption.length <= 5 * 10^4
      caption consists only of lowercase English letters.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "\"cdcd\"",
              "\"cccc\""
          ],
          [
              "\"aca\"",
              "\"aaa\""
          ],
          [
              "\"bc\"",
              "\"\""
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
