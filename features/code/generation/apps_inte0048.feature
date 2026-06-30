Feature: APPS/interview/48 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Bizon the Champion isn't just charming, he also is very smart.

      While some of us were learning the multiplication table, Bizon the Champion had fun in his own manner. Bizon the Champion painted an n × m multiplication table, where the element on the intersection of the i-th row and j-th column equals i·j (the rows and columns of the table are numbered starting from 1). Then he was asked: what number in the table is the k-th largest number? Bizon the Champion always answered correctly and immediately. Can you repeat his success?

      Consider the given multiplication table. If you write out all n·m numbers from the table in the non-decreasing order, then the k-th number you write out is called the k-th largest number.


      -----Input-----

      The single line contains integers n, m and k (1 ≤ n, m ≤ 5·10^5; 1 ≤ k ≤ n·m).


      -----Output-----

      Print the k-th largest number in a n × m multiplication table.


      -----Examples-----
      Input
      2 2 2

      Output
      2

      Input
      2 3 4

      Output
      3

      Input
      1 10 5

      Output
      5



      -----Note-----

      A 2 × 3 multiplication table looks like this:

      1 2 3

      2 4 6

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "2 2 2\n",
              "2\n"
          ],
          [
              "2 3 4\n",
              "3\n"
          ],
          [
              "1 10 5\n",
              "5\n"
          ],
          [
              "1 1 1\n",
              "1\n"
          ],
          [
              "10 1 7\n",
              "7\n"
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
