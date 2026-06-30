Feature: APPS/interview/49 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Let's write all the positive integer numbers one after another from $1$ without any delimiters (i.e. as a single string). It will be the infinite sequence starting with 123456789101112131415161718192021222324252627282930313233343536...

      Your task is to print the $k$-th digit of this sequence.


      -----Input-----

      The first and only line contains integer $k$ ($1 \le k \le 10^{12}$) — the position to process ($1$-based index).


      -----Output-----

      Print the $k$-th digit of the resulting infinite sequence.


      -----Examples-----
      Input
      7

      Output
      7

      Input
      21

      Output
      5

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "7\n",
              "7\n"
          ],
          [
              "21\n",
              "5\n"
          ],
          [
              "1\n",
              "1\n"
          ],
          [
              "2\n",
              "2\n"
          ],
          [
              "3\n",
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
