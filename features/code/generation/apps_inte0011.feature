Feature: APPS/interview/11 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Little Joty has got a task to do. She has a line of n tiles indexed from 1 to n. She has to paint them in a strange pattern.

      An unpainted tile should be painted Red if it's index is divisible by a and an unpainted tile should be painted Blue if it's index is divisible by b. So the tile with the number divisible by a and b can be either painted Red or Blue.

      After her painting is done, she will get p chocolates for each tile that is painted Red and q chocolates for each tile that is painted Blue.

      Note that she can paint tiles in any order she wants.

      Given the required information, find the maximum number of chocolates Joty can get.


      -----Input-----

      The only line contains five integers n, a, b, p and q (1 ≤ n, a, b, p, q ≤ 10^9).


      -----Output-----

      Print the only integer s — the maximum number of chocolates Joty can get.

      Note that the answer can be too large, so you should use 64-bit integer type to store it. In C++ you can use the long long integer type and in Java you can use long integer type.


      -----Examples-----
      Input
      5 2 3 12 15

      Output
      39

      Input
      20 2 3 3 5

      Output
      51

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "5 2 3 12 15\n",
              "39\n"
          ],
          [
              "20 2 3 3 5\n",
              "51\n"
          ],
          [
              "1 1 1 1 1\n",
              "1\n"
          ],
          [
              "1 2 2 2 2\n",
              "0\n"
          ],
          [
              "2 1 3 3 3\n",
              "6\n"
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
