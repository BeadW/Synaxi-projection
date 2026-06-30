Feature: LiveCodeBench/leetcode/hard — shortest-matching-substring
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a string s and a pattern string p, where p contains exactly two '*' characters.
      The '*' in p matches any sequence of zero or more characters.
      Return the length of the shortest substring in s that matches p. If there is no such substring, return -1.
      Note: The empty substring is considered valid.
 
      Example 1:

      Input: s = "abaacbaecebce", p = "ba*c*ce"
      Output: 8
      Explanation:
      The shortest matching substring of p in s is "baecebce".

      Example 2:

      Input: s = "baccbaadbc", p = "cc*baa*adb"
      Output: -1
      Explanation:
      There is no matching substring in s.

      Example 3:

      Input: s = "a", p = "**"
      Output: 0
      Explanation:
      The empty substring is the shortest matching substring.

      Example 4:

      Input: s = "madlogic", p = "*adlogi*"
      Output: 6
      Explanation:
      The shortest matching substring of p in s is "adlogi".

 
      Constraints:

      1 <= s.length <= 10^5
      2 <= p.length <= 10^5
      s contains only lowercase English letters.
      p contains only lowercase English letters and exactly two '*'.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "\"abaacbaecebce\"\n\"ba*c*ce\"",
              "8"
          ],
          [
              "\"baccbaadbc\"\n\"cc*baa*adb\"",
              "-1"
          ],
          [
              "\"a\"\n\"**\"",
              "0"
          ],
          [
              "\"madlogic\"\n\"*adlogi*\"",
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
