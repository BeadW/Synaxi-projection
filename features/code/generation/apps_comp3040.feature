Feature: APPS/competition/3040 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Given an input string composed solely of lowercase English letters, find the longest substring that occurs more than once in the input string. The two occurrences are allowed to partially overlap.

      -----Input-----
      The input is a single line containing a string of lowercase letters. The string contains more than one character, but no more than $10^5$. At least one letter will appear at least twice.

      -----Output-----
      Print a single line of output: the longest substring that occurs more than once in the input string. If there are multiple longest repeated substrings, print the one the would come first when the longest substrings are sorted in lexicographical (alphabetical) order.

      -----Examples-----
      Sample Input 1:
      abcefgabc
      Sample Output 1:
      abc

      Sample Input 2:
      abcbabcba
      Sample Output 2:
      abcba

      Sample Input 3:
      aaaa
      Sample Output 3:
      aaa

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "abcefgabc\n",
              "abc\n"
          ],
          [
              "abcbabcba\n",
              "abcba\n"
          ],
          [
              "aaaa\n",
              "aaa\n"
          ],
          [
              "bbcaadbbeaa\n",
              "aa\n"
          ]
      ]


      def test_apps():
          for i, (inp, expected) in enumerate(TEST_CASES):
              r = subprocess.run(
                  [sys.executable, "solution.py"],
                  input=inp,
                  capture_output=True,
                  text=True,
                  timeout=10,
              )
              assert r.returncode == 0, f"Case {i}: runtime error\n{r.stderr[:400]}"
              assert r.stdout.strip() == str(expected).strip(), (
                  f"Case {i}: expected {expected!r}, got {r.stdout!r}"
              )

      """

  Scenario: Agent solves the APPS problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py to read from stdin and write the correct answer to stdout so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
