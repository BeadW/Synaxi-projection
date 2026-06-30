Feature: APPS/interview/47 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an array $a$ consisting of $n$ integers. Beauty of array is the maximum sum of some consecutive subarray of this array (this subarray may be empty). For example, the beauty of the array [10, -5, 10, -4, 1] is 15, and the beauty of the array [-3, -5, -1] is 0.

      You may choose at most one consecutive subarray of $a$ and multiply all values contained in this subarray by $x$. You want to maximize the beauty of array after applying at most one such operation.


      -----Input-----

      The first line contains two integers $n$ and $x$ ($1 \le n \le 3 \cdot 10^5, -100 \le x \le 100$) — the length of array $a$ and the integer $x$ respectively.

      The second line contains $n$ integers $a_1, a_2, \dots, a_n$ ($-10^9 \le a_i \le 10^9$) — the array $a$.


      -----Output-----

      Print one integer — the maximum possible beauty of array $a$ after multiplying all values belonging to some consecutive subarray $x$.


      -----Examples-----
      Input
      5 -2
      -3 8 -2 1 -6

      Output
      22

      Input
      12 -3
      1 3 3 7 1 3 3 7 1 3 3 7

      Output
      42

      Input
      5 10
      -1 -2 -3 -4 -5

      Output
      0



      -----Note-----

      In the first test case we need to multiply the subarray [-2, 1, -6], and the array becomes [-3, 8, 4, -2, 12] with beauty 22 ([-3, 8, 4, -2, 12]).

      In the second test case we don't need to multiply any subarray at all.

      In the third test case no matter which subarray we multiply, the beauty of array will be equal to 0.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "5 -2\n-3 8 -2 1 -6\n",
              "22\n"
          ],
          [
              "12 -3\n1 3 3 7 1 3 3 7 1 3 3 7\n",
              "42\n"
          ],
          [
              "5 10\n-1 -2 -3 -4 -5\n",
              "0\n"
          ],
          [
              "10 100\n1000000000 1000000000 1000000000 1000000000 1000000000 1000000000 1000000000 1000000000 1000000000 1000000000\n",
              "1000000000000\n"
          ],
          [
              "3 0\n1 -10 2\n",
              "3\n"
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
