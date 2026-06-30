Feature: APPS/interview/20 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Karen is getting ready for a new school day!

       [Image] 

      It is currently hh:mm, given in a 24-hour format. As you know, Karen loves palindromes, and she believes that it is good luck to wake up when the time is a palindrome.

      What is the minimum number of minutes she should sleep, such that, when she wakes up, the time is a palindrome?

      Remember that a palindrome is a string that reads the same forwards and backwards. For instance, 05:39 is not a palindrome, because 05:39 backwards is 93:50. On the other hand, 05:50 is a palindrome, because 05:50 backwards is 05:50.


      -----Input-----

      The first and only line of input contains a single string in the format hh:mm (00 ≤  hh  ≤ 23, 00 ≤  mm  ≤ 59).


      -----Output-----

      Output a single integer on a line by itself, the minimum number of minutes she should sleep, such that, when she wakes up, the time is a palindrome.


      -----Examples-----
      Input
      05:39

      Output
      11

      Input
      13:31

      Output
      0

      Input
      23:59

      Output
      1



      -----Note-----

      In the first test case, the minimum number of minutes Karen should sleep for is 11. She can wake up at 05:50, when the time is a palindrome.

      In the second test case, Karen can wake up immediately, as the current time, 13:31, is already a palindrome.

      In the third test case, the minimum number of minutes Karen should sleep for is 1 minute. She can wake up at 00:00, when the time is a palindrome.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "05:39\n",
              "11\n"
          ],
          [
              "13:31\n",
              "0\n"
          ],
          [
              "23:59\n",
              "1\n"
          ],
          [
              "13:32\n",
              "69\n"
          ],
          [
              "14:40\n",
              "1\n"
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
