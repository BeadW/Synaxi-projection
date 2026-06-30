Feature: APPS/interview/22 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Let's call a string "s-palindrome" if it is symmetric about the middle of the string. For example, the string "oHo" is "s-palindrome", but the string "aa" is not. The string "aa" is not "s-palindrome", because the second half of it is not a mirror reflection of the first half.

       [Image] English alphabet 

      You are given a string s. Check if the string is "s-palindrome".


      -----Input-----

      The only line contains the string s (1 ≤ |s| ≤ 1000) which consists of only English letters.


      -----Output-----

      Print "TAK" if the string s is "s-palindrome" and "NIE" otherwise.


      -----Examples-----
      Input
      oXoxoXo

      Output
      TAK

      Input
      bod

      Output
      TAK

      Input
      ER

      Output
      NIE

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "oXoxoXo\n",
              "TAK\n"
          ],
          [
              "bod\n",
              "TAK\n"
          ],
          [
              "ER\n",
              "NIE\n"
          ],
          [
              "o\n",
              "TAK\n"
          ],
          [
              "a\n",
              "NIE\n"
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
