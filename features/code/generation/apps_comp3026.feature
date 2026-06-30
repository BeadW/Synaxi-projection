Feature: APPS/competition/3026 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Zapray really loves the Algorithmic Problem Solving course, but he is struggling with it. Recently the class studied Longest Increasing Subsequence (LIS). Zapray knows well how to compute the length of LIS for a given sequence. But on the exam paper there appears to be a different question: “We say an element in a sequence is critical, if removing it will cause the sequence’s LIS length to decrease. Can you find all the critical elements in the sequence below?” Zapray soon realizes that this is a much bigger challenge.

      -----Input-----
      The input starts with a single integer $n$ ($2 \leq n \leq 10^5$), the length of the given sequence. The next line has $n$ integers giving the numbers in the sequence. The given sequence is a permutation in which each integer from $1$ to $n$ appears exactly once.

      -----Output-----
      Output all critical elements in the sequence in ascending order. If none of the elements are critical, output “-1”.

      -----Examples-----
      Sample Input 1:
      4
      1 3 2 4
      Sample Output 1:
      1 4

      Sample Input 2:
      5
      1 2 3 4 5
      Sample Output 2:
      1 2 3 4 5

      Sample Input 3:
      4
      2 1 4 3
      Sample Output 3:
      -1

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "4\n1 3 2 4\n",
              "1 4\n"
          ],
          [
              "5\n1 2 3 4 5\n",
              "1 2 3 4 5\n"
          ],
          [
              "4\n2 1 4 3\n",
              "-1\n"
          ],
          [
              "4\n4 3 1 2\n",
              "1 2\n"
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
