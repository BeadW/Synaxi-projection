Feature: APPS/interview/8 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Tokitsukaze is playing a game derivated from Japanese mahjong. In this game, she has three tiles in her hand. Each tile she owns is a suited tile, which means it has a suit (manzu, pinzu or souzu) and a number (a digit ranged from $1$ to $9$). In this problem, we use one digit and one lowercase letter, which is the first character of the suit, to represent a suited tile. All possible suited tiles are represented as 1m, 2m, $\ldots$, 9m, 1p, 2p, $\ldots$, 9p, 1s, 2s, $\ldots$, 9s.

      In order to win the game, she must have at least one mentsu (described below) in her hand, so sometimes she should draw extra suited tiles. After drawing a tile, the number of her tiles increases by one. She can draw any tiles she wants, including those already in her hand.

      Do you know the minimum number of extra suited tiles she needs to draw so that she can win?

      Here are some useful definitions in this game:  A mentsu, also known as meld, is formed by a koutsu or a shuntsu;  A koutsu, also known as triplet, is made of three identical tiles, such as [1m, 1m, 1m], however, [1m, 1p, 1s] or [1m, 4m, 7m] is NOT a koutsu;  A shuntsu, also known as sequence, is made of three sequential numbered tiles in the same suit, such as [1m, 2m, 3m] and [5s, 7s, 6s], however, [9m, 1m, 2m] or [1m, 2p, 3s] is NOT a shuntsu. 

      Some examples:   [2m, 3p, 2s, 4m, 1s, 2s, 4s] — it contains no koutsu or shuntsu, so it includes no mentsu;  [4s, 3m, 3p, 4s, 5p, 4s, 5p] — it contains a koutsu, [4s, 4s, 4s], but no shuntsu, so it includes a mentsu;  [5p, 5s, 9m, 4p, 1s, 7p, 7m, 6p] — it contains no koutsu but a shuntsu, [5p, 4p, 6p] or [5p, 7p, 6p], so it includes a mentsu. 

      Note that the order of tiles is unnecessary and you can assume the number of each type of suited tiles she can draw is infinite.


      -----Input-----

      The only line contains three strings — the tiles in Tokitsukaze's hand. For each string, the first character is a digit ranged from $1$ to $9$ and the second character is m, p or s.


      -----Output--
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
              "1s 2s 3s\n",
              "0\n"
          ],
          [
              "9m 9m 9m\n",
              "0\n"
          ],
          [
              "3p 9m 2p\n",
              "1\n"
          ],
          [
              "8p 2s 9m\n",
              "2\n"
          ],
          [
              "5s 8m 5s\n",
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
