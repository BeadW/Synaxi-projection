Feature: APPS/interview/77 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given sequence a_1, a_2, ..., a_{n} of integer numbers of length n. Your task is to find such subsequence that its sum is odd and maximum among all such subsequences. It's guaranteed that given sequence contains subsequence with odd sum.

      Subsequence is a sequence that can be derived from another sequence by deleting some elements without changing the order of the remaining elements.

      You should write a program which finds sum of the best subsequence.


      -----Input-----

      The first line contains integer number n (1 ≤ n ≤ 10^5).

      The second line contains n integer numbers a_1, a_2, ..., a_{n} ( - 10^4 ≤ a_{i} ≤ 10^4). The sequence contains at least one subsequence with odd sum.


      -----Output-----

      Print sum of resulting subseqeuence.


      -----Examples-----
      Input
      4
      -2 2 -3 1

      Output
      3

      Input
      3
      2 -5 -3

      Output
      -1



      -----Note-----

      In the first example sum of the second and the fourth elements is 3.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "4\n-2 2 -3 1\n",
              "3\n"
          ],
          [
              "3\n2 -5 -3\n",
              "-1\n"
          ],
          [
              "1\n1\n",
              "1\n"
          ],
          [
              "1\n-1\n",
              "-1\n"
          ],
          [
              "15\n-6004 4882 9052 413 6056 4306 9946 -4616 -6135 906 -1718 5252 -2866 9061 4046\n",
              "53507\n"
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
