Feature: APPS/interview/83 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an array of $n$ integers: $a_1, a_2, \ldots, a_n$. Your task is to find some non-zero integer $d$ ($-10^3 \leq d \leq 10^3$) such that, after each number in the array is divided by $d$, the number of positive numbers that are presented in the array is greater than or equal to half of the array size (i.e., at least $\lceil\frac{n}{2}\rceil$). Note that those positive numbers do not need to be an integer (e.g., a $2.5$ counts as a positive number). If there are multiple values of $d$ that satisfy the condition, you may print any of them. In case that there is no such $d$, print a single integer $0$.

      Recall that $\lceil x \rceil$ represents the smallest integer that is not less than $x$ and that zero ($0$) is neither positive nor negative.


      -----Input-----

      The first line contains one integer $n$ ($1 \le n \le 100$) — the number of elements in the array.

      The second line contains $n$ space-separated integers $a_1, a_2, \ldots, a_n$ ($-10^3 \le a_i \le 10^3$).


      -----Output-----

      Print one integer $d$ ($-10^3 \leq d \leq 10^3$ and $d \neq 0$) that satisfies the given condition. If there are multiple values of $d$ that satisfy the condition, you may print any of them. In case that there is no such $d$, print a single integer $0$.


      -----Examples-----
      Input
      5
      10 0 -7 2 6
      Output
      4
      Input
      7
      0 0 1 -1 0 0 2

      Output
      0


      -----Note-----

      In the first sample, $n = 5$, so we need at least $\lceil\frac{5}{2}\rceil = 3$ positive numbers after division. If $d = 4$, the array after division is $[2.5, 0, -1.75, 0.5, 1.5]$, in which there are $3$ positive numbers (namely: $2.5$, $0.5$, and $1.5$).

      In the second sample, there is no valid $d$, so $0$ should be printed.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "5\n10 0 -7 2 6\n",
              "1"
          ],
          [
              "7\n0 0 1 -1 0 0 2\n",
              "0"
          ],
          [
              "5\n0 0 0 1 1\n",
              "0"
          ],
          [
              "1\n777\n",
              "1"
          ],
          [
              "2\n1 0\n",
              "1"
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
