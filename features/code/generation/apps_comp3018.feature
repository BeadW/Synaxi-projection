Feature: APPS/competition/3018 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Two players are playing a game with a set of $K$ six-sided dice. One player calls out a number in the range $K\ldots 6K$ and the other tries to roll that number. After the first roll, the player is allowed to pick up any number ($0\ldots K$) of dice and re-roll them.

      Given the number of dice, the target number the player wants to roll, and the set of numbers the player obtained on the first roll, what number of dice should the player pick up to maximize their chances of getting the target number on the second roll?

      -----Input-----
      Input begins with a line containing $2$ integers, $K$, the number of dice, and $T$, the target number. The bounds are $2 \leq K \leq 24$ and $K \leq T \leq 6K$.

      The next line contains $K$ integers, indicating the numbers that were rolled on each of the dice on the first roll. All will be integers in the range $1\ldots 6$.

      -----Output-----
      Print a single line containing an integer denoting the number of dice that the roller should pick up and re-roll in order to maximize the chances of getting an overall sum of $T$. (The roller will be able to choose which dice to pick up, but you are only asked to print the number of dice, not which ones.)

      If there are more than one numbers of dice that can be picked up to achieve the same probability of getting to $T$, print the smallest such value.

      -----Examples-----
      Sample Input 1:
      3 9
      5 4 1
      Sample Output 1:
      1

      Sample Input 2:
      4 13
      2 2 2 2
      Sample Output 2:
      3

      Sample Input 3:
      18 90
      1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6
      Sample Output 3:
      12

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "3 9\n5 4 1\n",
              "1\n"
          ],
          [
              "4 13\n2 2 2 2\n",
              "3\n"
          ],
          [
              "18 90\n1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6\n",
              "12\n"
          ],
          [
              "6 21\n1 2 3 4 5 6\n",
              "0\n"
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
