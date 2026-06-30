Feature: APPS/competition/3017 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Theta has been learning about powers of $2$ in school. She notices that some numbers when written out contain powers of $2$ in their digit representation: for instance, $12560$ contains $256$ which is a power of $2$. She has been wondering how many such numbers there are.

      Can you write a program that counts how many numbers contain a given power of $2$?

      -----Input-----
      The input consists of a single line with two integers $n$ and $e$ ($0 \le n \le 9 \cdot 10^{18}, 0 \le e \le 62$).

      -----Output-----
      Output a single integer that is equal to the number of distinct integers $k$ ($0 \le k \le n$) whose decimal representation contains the digits of $2^e$ as a substring.

      -----Examples-----
      Sample Input 1:
      1000000 1
      Sample Output 1:
      468559

      Sample Input 2:
      1000000 5
      Sample Output 2:
      49401

      Sample Input 3:
      1000000 16
      Sample Output 3:
      20

      Sample Input 4:
      9000000000000000000 62
      Sample Output 4:
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
              "1000000 1\n",
              "468559\n"
          ],
          [
              "1000000 5\n",
              "49401\n"
          ],
          [
              "1000000 16\n",
              "20\n"
          ],
          [
              "9000000000000000000 62\n",
              "1\n"
          ],
          [
              "5432123456789876543 33\n",
              "4842258985\n"
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
