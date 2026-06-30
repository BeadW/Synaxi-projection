Feature: APPS/interview/3 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You have a long fence which consists of $n$ sections. Unfortunately, it is not painted, so you decided to hire $q$ painters to paint it. $i$-th painter will paint all sections $x$ such that $l_i \le x \le r_i$.

      Unfortunately, you are on a tight budget, so you may hire only $q - 2$ painters. Obviously, only painters you hire will do their work.

      You want to maximize the number of painted sections if you choose $q - 2$ painters optimally. A section is considered painted if at least one painter paints it.


      -----Input-----

      The first line contains two integers $n$ and $q$ ($3 \le n, q \le 5000$) — the number of sections and the number of painters availible for hire, respectively.

      Then $q$ lines follow, each describing one of the painters: $i$-th line contains two integers $l_i$ and $r_i$ ($1 \le l_i \le r_i \le n$).


      -----Output-----

      Print one integer — maximum number of painted sections if you hire $q - 2$ painters.


      -----Examples-----
      Input
      7 5
      1 4
      4 5
      5 6
      6 7
      3 5

      Output
      7

      Input
      4 3
      1 1
      2 2
      3 4

      Output
      2

      Input
      4 4
      1 1
      2 2
      2 3
      3 4

      Output
      3

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "7 5\n1 4\n4 5\n5 6\n6 7\n3 5\n",
              "7\n"
          ],
          [
              "4 3\n1 1\n2 2\n3 4\n",
              "2\n"
          ],
          [
              "4 4\n1 1\n2 2\n2 3\n3 4\n",
              "3\n"
          ],
          [
              "3 3\n1 3\n1 1\n2 2\n",
              "3\n"
          ],
          [
              "6 3\n1 6\n1 3\n4 6\n",
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
