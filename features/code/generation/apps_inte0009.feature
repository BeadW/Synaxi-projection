Feature: APPS/interview/9 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Yet another round on DecoForces is coming! Grandpa Maks wanted to participate in it but someone has stolen his precious sofa! And how can one perform well with such a major loss?

      Fortunately, the thief had left a note for Grandpa Maks. This note got Maks to the sofa storehouse. Still he had no idea which sofa belongs to him as they all looked the same!

      The storehouse is represented as matrix n × m. Every sofa takes two neighbouring by some side cells. No cell is covered by more than one sofa. There can be empty cells.

      Sofa A is standing to the left of sofa B if there exist two such cells a and b that x_{a} < x_{b}, a is covered by A and b is covered by B. Sofa A is standing to the top of sofa B if there exist two such cells a and b that y_{a} < y_{b}, a is covered by A and b is covered by B. Right and bottom conditions are declared the same way. 

      Note that in all conditions A ≠ B. Also some sofa A can be both to the top of another sofa B and to the bottom of it. The same is for left and right conditions.

      The note also stated that there are cnt_{l} sofas to the left of Grandpa Maks's sofa, cnt_{r} — to the right, cnt_{t} — to the top and cnt_{b} — to the bottom.

      Grandpa Maks asks you to help him to identify his sofa. It is guaranteed that there is no more than one sofa of given conditions.

      Output the number of Grandpa Maks's sofa. If there is no such sofa that all the conditions are met for it then output -1.


      -----Input-----

      The first line contains one integer number d (1 ≤ d ≤ 10^5) — the number of sofas in the storehouse.

      The second line contains two integer numbers n, m (1 ≤ n, m ≤ 10^5) — the size of the storehouse.

      Next d lines contains four integer numbers x_1, y_1, x_2, y_2 (1 ≤ x_1, x_2 ≤ n, 1 ≤ y_1, y_2 ≤ m) — coordinates of the i-th sofa. It is guaranteed that cells (x_1, y_1) and (x_2, y_2) have common side, (x_1, y_1)  ≠  (x_2, y_2) and no cell is covered by more than one sofa.

      The last line contains four integer numbers cnt_{l}, cnt_{r}, cnt
      ...(truncated)

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "2\n3 2\n3 1 3 2\n1 2 2 2\n1 0 0 1\n",
              "1\n"
          ],
          [
              "3\n10 10\n1 2 1 1\n5 5 6 5\n6 4 5 4\n2 1 2 0\n",
              "2\n"
          ],
          [
              "2\n2 2\n2 1 1 1\n1 2 2 2\n1 0 0 0\n",
              "-1\n"
          ],
          [
              "1\n1 2\n1 1 1 2\n0 0 0 0\n",
              "1\n"
          ],
          [
              "1\n2 1\n2 1 1 1\n0 0 0 0\n",
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
