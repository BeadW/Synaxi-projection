Feature: APPS/interview/21 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Nicholas has an array a that contains n distinct integers from 1 to n. In other words, Nicholas has a permutation of size n.

      Nicholas want the minimum element (integer 1) and the maximum element (integer n) to be as far as possible from each other. He wants to perform exactly one swap in order to maximize the distance between the minimum and the maximum elements. The distance between two elements is considered to be equal to the absolute difference between their positions.


      -----Input-----

      The first line of the input contains a single integer n (2 ≤ n ≤ 100) — the size of the permutation.

      The second line of the input contains n distinct integers a_1, a_2, ..., a_{n} (1 ≤ a_{i} ≤ n), where a_{i} is equal to the element at the i-th position.


      -----Output-----

      Print a single integer — the maximum possible distance between the minimum and the maximum elements Nicholas can achieve by performing exactly one swap.


      -----Examples-----
      Input
      5
      4 5 1 3 2

      Output
      3

      Input
      7
      1 6 5 3 4 7 2

      Output
      6

      Input
      6
      6 5 4 3 2 1

      Output
      5



      -----Note-----

      In the first sample, one may obtain the optimal answer by swapping elements 1 and 2.

      In the second sample, the minimum and the maximum elements will be located in the opposite ends of the array if we swap 7 and 2.

      In the third sample, the distance between the minimum and the maximum elements is already maximum possible, so we just perform some unnecessary swap, for example, one can swap 5 and 2.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "5\n4 5 1 3 2\n",
              "3\n"
          ],
          [
              "7\n1 6 5 3 4 7 2\n",
              "6\n"
          ],
          [
              "6\n6 5 4 3 2 1\n",
              "5\n"
          ],
          [
              "2\n1 2\n",
              "1\n"
          ],
          [
              "2\n2 1\n",
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
