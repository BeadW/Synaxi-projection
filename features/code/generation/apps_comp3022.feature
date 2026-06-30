Feature: APPS/competition/3022 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Is a world without cookies really worth living in? Alf and Beata do not think so. That’s why they spent the entire weekend baking an enormous amount of cookies. They baked $A$ almond biscuits, $B$ butter cookies and $C$ chocolate macarons.

      It is now time to eat all these delicious cookies with their friends. The cookies will be divided up among all the friends. However, this division must be done such that everyone can eat all of their cookies without having to eat the same kind of cookie twice in a row (that would be very unpleasant).

      Furthermore, Alf and Beata wants as few cookies as possible to go to waste – they spent a lot of time preparing them, after all. Can you determine the maximum amount of cookies that can be distributed among everyone?

      -----Input-----
      The first and only line contains four integers $N$ ($2 \le N \le 10^9$), the number of friends eating cookies including Alf and Beata, and $A$, $B$ and $C$ ($0 \le A, B, C \le 10^9$), the amount of cookies of each of the three times Alf and Beata baked.

      -----Output-----
      Output a single integer – the number of cookies Alf and Beata are able to distribute.

      -----Examples-----
      Sample Input 1:
      2 3 3 3
      Sample Output 1:
      9

      Sample Input 2:
      10 20 0 0
      Sample Output 2:
      10

      Sample Input 3:
      100 20 543 12
      Sample Output 3:
      164

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "2 3 3 3\n",
              "9\n"
          ],
          [
              "10 20 0 0\n",
              "10\n"
          ],
          [
              "100 20 543 12\n",
              "164\n"
          ],
          [
              "1000000000 1000000000 1000000000 1000000000\n",
              "3000000000\n"
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
