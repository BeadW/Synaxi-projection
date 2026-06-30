Feature: APPS/competition/3024 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Let $s$ be a given string of up to $10^6$ digits. Find the maximal $k$ for which it is possible to partition $s$ into $k$ consecutive contiguous substrings, such that the $k$ parts form a palindrome. More precisely, we say that strings $s_0, s_1, \dots , s_{k-1}$ form a palindrome if $s_ i = s_{k-1-i}$ for all $0\leq i < k$.

      In the first sample case, we can split the string 652526 into $4$ parts as 6|52|52|6, and these parts together form a palindrome. It turns out that it is impossible to split this input into more than $4$ parts while still making sure the parts form a palindrome.

      -----Input-----
       - A nonempty string of up to $10^6$ digits.

      -----Output-----
       - Print the maximal value of $k$ on a single line.

      -----Examples-----
      Sample Input 1:
      652526
      Sample Output 1:
      4

      Sample Input 2:
      12121131221
      Sample Output 2:
      7

      Sample Input 3:
      123456789
      Sample Output 3:
      1

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "652526\n",
              "4\n"
          ],
          [
              "12121131221\n",
              "7\n"
          ],
          [
              "123456789\n",
              "1\n"
          ],
          [
              "132594414896459441321\n",
              "9\n"
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
