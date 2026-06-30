Feature: APPS/interview/18 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Petya recieved a gift of a string s with length up to 10^5 characters for his birthday. He took two more empty strings t and u and decided to play a game. This game has two possible moves:  Extract the first character of s and append t with this character.  Extract the last character of t and append u with this character. 

      Petya wants to get strings s and t empty and string u lexicographically minimal.

      You should write a program that will help Petya win the game.


      -----Input-----

      First line contains non-empty string s (1 ≤ |s| ≤ 10^5), consisting of lowercase English letters.


      -----Output-----

      Print resulting string u.


      -----Examples-----
      Input
      cab

      Output
      abc

      Input
      acdb

      Output
      abdc

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "cab\n",
              "abc\n"
          ],
          [
              "acdb\n",
              "abdc\n"
          ],
          [
              "a\n",
              "a\n"
          ],
          [
              "ab\n",
              "ab\n"
          ],
          [
              "ba\n",
              "ab\n"
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
