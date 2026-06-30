Feature: APPS/interview/62 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Since most contestants do not read this part, I have to repeat that Bitlandians are quite weird. They have their own jobs, their own working method, their own lives, their own sausages and their own games!

      Since you are so curious about Bitland, I'll give you the chance of peeking at one of these games.

      BitLGM and BitAryo are playing yet another of their crazy-looking genius-needed Bitlandish games. They've got a sequence of n non-negative integers a_1, a_2, ..., a_{n}. The players make moves in turns. BitLGM moves first. Each player can and must do one of the two following actions in his turn:

        Take one of the integers (we'll denote it as a_{i}). Choose integer x (1 ≤ x ≤ a_{i}). And then decrease a_{i} by x, that is, apply assignment: a_{i} = a_{i} - x.  Choose integer x $(1 \leq x \leq \operatorname{min}_{i = 1} a_{i})$. And then decrease all a_{i} by x, that is, apply assignment: a_{i} = a_{i} - x, for all i. 

      The player who cannot make a move loses.

      You're given the initial sequence a_1, a_2, ..., a_{n}. Determine who wins, if both players plays optimally well and if BitLGM and BitAryo start playing the described game in this sequence.


      -----Input-----

      The first line contains an integer n (1 ≤ n ≤ 3).

      The next line contains n integers a_1, a_2, ..., a_{n} (0 ≤ a_{i} < 300).


      -----Output-----

      Write the name of the winner (provided that both players play optimally well). Either "BitLGM" or "BitAryo" (without the quotes).


      -----Examples-----
      Input
      2
      1 1

      Output
      BitLGM

      Input
      2
      1 2

      Output
      BitAryo

      Input
      3
      1 2 1

      Output
      BitLGM

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "2\n1 1\n",
              "BitLGM\n"
          ],
          [
              "2\n1 2\n",
              "BitAryo\n"
          ],
          [
              "3\n1 2 1\n",
              "BitLGM\n"
          ],
          [
              "2\n1 3\n",
              "BitLGM\n"
          ],
          [
              "2\n3 5\n",
              "BitAryo\n"
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
