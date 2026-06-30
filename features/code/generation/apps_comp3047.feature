Feature: APPS/competition/3047 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Theta likes to play Lure of the Labyrinth, which is an online game that uses a compelling graphic novel storyline to engage middle grades students in mathematical thinking and problem-solving. To find lost pets, students have to infiltrate a world of monsters and solve puzzles! Implemented by a professional game studio, these puzzles are quite engaging and challenging.

      In the manager’s cafeteria, students are asked to practice proportions by serving $5$ monsters sitting at the table: Salamander, Yeti, Golem, Imp, and Kraken. Each monster wants some amount of burger, slop, sushi, and drumstick.

      The amount of each item each monster wants on their plate is proportional to the amount of each of the other items that monster wants, and the proportionality ratio is the same for all monsters.

      For instance, as shown in sample input $1$ and in the accompanying figure, if Golem (center) wants $6$ units of burger on his plate and $12$ units of drumstick, and Salamander (left) wants $40$ units of drumstick, then Salamander will want $20$ units of burger. Students practicing proportions will program the dispenser machine to release $20$ units of burger. Similarly, Kraken (right) wants $36$ units of drumstick because it has $81$ units of slop on its plate and Salamander has $40$ units of drumstick and $90$ units of slop. If the students compute all proportions in time, the monsters eat and a pet can be saved!

      As students progress in the game and reach more difficult levels, fewer and fewer amounts are given, requiring more intuition and thinking to solve the puzzle.

      Give a set of partially filled plates, write a program that computes the number of distinct solutions that are consistent with it!

      -----Input-----
      The input consists of $2$ lines of $10$ entries each describing the partially filled plates. The first line describes the top row (burgers and slop), the second line describes the bottom row (sushi and drumstick). On each line, the first $2$ entries describe Salamander
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
              "_ 90 22 _ 6 _ _ _ _ 81\n_ 40 _ _ _ 12 60 _ 90 _\n",
              "1\n"
          ],
          [
              "85 55 _ 99 51 _ _ _ _ _\n_ _ _ _ _ _ _ 85 63 153\n",
              "1\n"
          ],
          [
              "160 _ _ 136 _ _ _ _ _ 170\n_ _ _ _ 120 _ _ 144 _ _\n",
              "8640\n"
          ],
          [
              "36 99 _ 55 _ 99 _ 77 _ _\n_ 144 _ _ 27 _ 21 112 _ _\n",
              "many\n"
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
