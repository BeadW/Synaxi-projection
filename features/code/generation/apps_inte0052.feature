Feature: APPS/interview/52 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Daniel is organizing a football tournament. He has come up with the following tournament format:   In the first several (possibly zero) stages, while the number of teams is even, they split in pairs and play one game for each pair. At each stage the loser of each pair is eliminated (there are no draws). Such stages are held while the number of teams is even.  Eventually there will be an odd number of teams remaining. If there is one team remaining, it will be declared the winner, and the tournament ends. Otherwise each of the remaining teams will play with each other remaining team once in round robin tournament (if there are x teams, there will be $\frac{x \cdot(x - 1)}{2}$ games), and the tournament ends. 

      For example, if there were 20 teams initially, they would begin by playing 10 games. So, 10 teams would be eliminated, and the remaining 10 would play 5 games. Then the remaining 5 teams would play 10 games in a round robin tournament. In total there would be 10+5+10=25 games.

      Daniel has already booked the stadium for n games. Help him to determine how many teams he should invite so that the tournament needs exactly n games. You should print all possible numbers of teams that will yield exactly n games in ascending order, or -1 if there are no such numbers.


      -----Input-----

      The first line contains a single integer n (1 ≤ n ≤ 10^18), the number of games that should be played.

      Please, do not use the %lld specifier to read or write 64-bit integers in С++. It is preferred to use the cin, cout streams or the %I64d specifier.


      -----Output-----

      Print all possible numbers of invited teams in ascending order, one per line. If exactly n games cannot be played, output one number: -1.


      -----Examples-----
      Input
      3

      Output
      3
      4

      Input
      25

      Output
      20

      Input
      2

      Output
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
              "3\n",
              "3\n4\n"
          ],
          [
              "25\n",
              "20\n"
          ],
          [
              "2\n",
              "-1\n"
          ],
          [
              "1\n",
              "2\n"
          ],
          [
              "15\n",
              "10\n16\n"
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
