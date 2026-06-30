Feature: APPS/interview/63 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Vova again tries to play some computer card game.

      The rules of deck creation in this game are simple. Vova is given an existing deck of n cards and a magic number k. The order of the cards in the deck is fixed. Each card has a number written on it; number a_{i} is written on the i-th card in the deck.

      After receiving the deck and the magic number, Vova removes x (possibly x = 0) cards from the top of the deck, y (possibly y = 0) cards from the bottom of the deck, and the rest of the deck is his new deck (Vova has to leave at least one card in the deck after removing cards). So Vova's new deck actually contains cards x + 1, x + 2, ... n - y - 1, n - y from the original deck.

      Vova's new deck is considered valid iff the product of all numbers written on the cards in his new deck is divisible by k. So Vova received a deck (possibly not a valid one) and a number k, and now he wonders, how many ways are there to choose x and y so the deck he will get after removing x cards from the top and y cards from the bottom is valid?


      -----Input-----

      The first line contains two integers n and k (1 ≤ n ≤ 100 000, 1 ≤ k ≤ 10^9).

      The second line contains n integers a_1, a_2, ..., a_{n} (1 ≤ a_{i} ≤ 10^9) — the numbers written on the cards.


      -----Output-----

      Print the number of ways to choose x and y so the resulting deck is valid.


      -----Examples-----
      Input
      3 4
      6 2 8

      Output
      4

      Input
      3 6
      9 1 14

      Output
      1



      -----Note-----

      In the first example the possible values of x and y are:

        x = 0, y = 0;  x = 1, y = 0;  x = 2, y = 0;  x = 0, y = 1.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "3 4\n6 2 8\n",
              "4\n"
          ],
          [
              "3 6\n9 1 14\n",
              "1\n"
          ],
          [
              "5 1\n1 3 1 3 1\n",
              "15\n"
          ],
          [
              "5 1\n5 5 5 5 5\n",
              "15\n"
          ],
          [
              "5 1\n5 4 4 4 4\n",
              "15\n"
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
