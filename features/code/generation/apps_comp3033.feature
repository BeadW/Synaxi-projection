Feature: APPS/competition/3033 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      For every positive integer we may obtain a non-negative integer by multiplying its digits. This defines a function $f$, e.g. $f(38) = 24$.

      This function gets more interesting if we allow for other bases. In base $3$, the number $80$ is written as $2222$, so: $f_3(80) = 16$.

      We want you to solve the reverse problem: given a base $B$ and a number $N$, what is the smallest positive integer $X$ such that $f_ B(X) = N$?

      -----Input-----
      The input consists of a single line containing two integers $B$ and $N$, satisfying $2 < B \leq 10000$ and $0 < N < 2^{63}$.

      -----Output-----
      Output the smallest positive integer solution $X$ of the equation $f_ B(X) = N$. If no such $X$ exists, output the word “impossible”. The input is carefully chosen such that $X < 2^{63}$ holds (if $X$ exists).

      -----Examples-----
      Sample Input 1:
      10 24
      Sample Output 1:
      38

      Sample Input 2:
      10 11
      Sample Output 2:
      impossible

      Sample Input 3:
      9 216
      Sample Output 3:
      546

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "10 24\n",
              "38\n"
          ],
          [
              "10 11\n",
              "impossible\n"
          ],
          [
              "9 216\n",
              "546\n"
          ],
          [
              "10000 5810859769934419200\n",
              "5989840988999909996\n"
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
