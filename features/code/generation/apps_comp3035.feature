Feature: APPS/competition/3035 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      The lunch break just started! Your mother gave you one litre of pink lemonade. You do not like pink lemonade and want blue lemonade instead. Fortunately for you the other children in class are willing to trade with you.

      Each of them is willing to offer you any quantity of the virtually infinite amount of lemonade they got from their mother, in exchange for their favourite lemonade, according to some exchange rate. The other children are sitting in a long row in the class room and you will walk along the row, passing each child only once. You are not allowed to walk back! Of course, you want to maximise the amount of blue lemonade you end up with. In case you can obtain more than $10$ litres of blue lemonade, this is more than you will need, and you will throw away any excess (and keep the $10$ litres).

      Fortunately, you know in advance what everybody is offering for trade. Your task is to write a program to find the maximum amount of blue lemonade that you can obtain.

      -----Input-----
      The input consists of the following:
       - One line containing a single integer $0\leq N \leq 10^5$, the number of children in the class room, excluding yourself;
       - $N$ lines, each containing two strings $O, W$ and a floating point number $0.5 < R < 2$, the name of the lemonade that is offered, the name of the lemonade that is wanted, and the exchange rate: for every litre of lemonade $W$ that you trade you get $R$ litres of lemonade $O$ in return. Exchange rates are given with at most $7$ digits after the decimal point.

      All strings are guaranteed to have at most $10$ alphanumeric characters.

      -----Output-----
      Output a single line containing a single floating point number $M$, the maximum amount (in litres) of blue lemonade that you can obtain. In case you could obtain more than $10$ litres, $M$ is considered to be $10$. You are required to output $M$ with absolute precision $10^{-6}$.

      -----Examples-----
      Sample Input 1:
      3
      blue pink 1.0
      red pink 1.5
      blue red 1.0
      Sample Output 1:
      1.5000
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
              "3\nblue pink 1.0\nred pink 1.5\nblue red 1.0\n",
              "1.500000000000000\n"
          ],
          [
              "2\nblue red 1.0\nred pink 1.5\n",
              "0.000000000000000\n"
          ],
          [
              "4\norange pink 1.9\nyellow orange 1.9\ngreen yellow 1.9\nblue green 1.9\n",
              "10.000000000000000\n"
          ],
          [
              "8\nred pink 1.9\norange red 1.9\nyellow orange 1.9\ngreen yellow 1.9\nindigo green 0.6\nviolet indigo 0.6\npurple violet 0.6\nblue purple 0.6\n",
              "1.688960160000000\n"
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
