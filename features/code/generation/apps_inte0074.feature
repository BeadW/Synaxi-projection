Feature: APPS/interview/74 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Dima loves representing an odd number as the sum of multiple primes, and Lisa loves it when there are at most three primes. Help them to represent the given number as the sum of at most than three primes.

      More formally, you are given an odd numer n. Find a set of numbers p_{i} (1 ≤ i ≤ k), such that



       1 ≤ k ≤ 3

       p_{i} is a prime

       $\sum_{i = 1}^{k} p_{i} = n$

      The numbers p_{i} do not necessarily have to be distinct. It is guaranteed that at least one possible solution exists.


      -----Input-----

      The single line contains an odd number n (3 ≤ n < 10^9).


      -----Output-----

      In the first line print k (1 ≤ k ≤ 3), showing how many numbers are in the representation you found.

      In the second line print numbers p_{i} in any order. If there are multiple possible solutions, you can print any of them.


      -----Examples-----
      Input
      27

      Output
      3
      5 11 11



      -----Note-----

      A prime is an integer strictly larger than one that is divisible only by one and by itself.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "27\n",
              "3\n2 2 23"
          ],
          [
              "3\n",
              "1\n3"
          ],
          [
              "25\n",
              "2\n2 23"
          ],
          [
              "9\n",
              "2\n2 7"
          ],
          [
              "91\n",
              "2\n2 89"
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
