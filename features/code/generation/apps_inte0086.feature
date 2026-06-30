Feature: APPS/interview/86 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Polycarp and Vasiliy love simple logical games. Today they play a game with infinite chessboard and one pawn for each player. Polycarp and Vasiliy move in turns, Polycarp starts. In each turn Polycarp can move his pawn from cell (x, y) to (x - 1, y) or (x, y - 1). Vasiliy can move his pawn from (x, y) to one of cells: (x - 1, y), (x - 1, y - 1) and (x, y - 1). Both players are also allowed to skip move. 

      There are some additional restrictions — a player is forbidden to move his pawn to a cell with negative x-coordinate or y-coordinate or to the cell containing opponent's pawn The winner is the first person to reach cell (0, 0). 

      You are given the starting coordinates of both pawns. Determine who will win if both of them play optimally well.


      -----Input-----

      The first line contains four integers: x_{p}, y_{p}, x_{v}, y_{v} (0 ≤ x_{p}, y_{p}, x_{v}, y_{v} ≤ 10^5) — Polycarp's and Vasiliy's starting coordinates.

      It is guaranteed that in the beginning the pawns are in different cells and none of them is in the cell (0, 0).


      -----Output-----

      Output the name of the winner: "Polycarp" or "Vasiliy".


      -----Examples-----
      Input
      2 1 2 2

      Output
      Polycarp

      Input
      4 7 7 4

      Output
      Vasiliy



      -----Note-----

      In the first sample test Polycarp starts in (2, 1) and will move to (1, 1) in the first turn. No matter what his opponent is doing, in the second turn Polycarp can move to (1, 0) and finally to (0, 0) in the third turn.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "2 1 2 2\n",
              "Polycarp\n"
          ],
          [
              "4 7 7 4\n",
              "Vasiliy\n"
          ],
          [
              "20 0 7 22\n",
              "Polycarp\n"
          ],
          [
              "80 100 83 97\n",
              "Vasiliy\n"
          ],
          [
              "80 100 77 103\n",
              "Vasiliy\n"
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
