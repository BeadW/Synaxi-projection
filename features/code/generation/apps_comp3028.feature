Feature: APPS/competition/3028 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Primonimo is a game played on an $n \times m$ board filled with numbers taken from the range $1 \ldots p$ for some prime number $p$. At each move, a player selects a square and adds $1$ to the numbers in all squares in the same row and column as the selected square. If a square already shows the number $p$, it wraps around to $1$.

      The game is won if all squares show $p$. Given an initial board, find a sequence of moves that wins the game!

      -----Input-----
      The input consists of a single test case. The first line contains three numbers $n \ m \ p$ denoting the number of rows $n$ ($1 \le n \le 20$), the number of columns $m$ ($1 \le m \le 20$), and a prime number $p$ ($2 \le p \le 97$). Each of the next $n$ lines consists of $m$ numbers in the range $1 \ldots p$.

      -----Output-----
      If a winning sequence of at most $p \cdot m \cdot n$ moves exists, output an integer $k \le p \cdot m \cdot n$ denoting the number of moves in the sequence. Then output $k$ moves as a sequence of integers that numbers the board in row-major order, starting with $1$. If there are multiple such sequences, you may output any one of them. If no winning sequence exists, output -1.

      -----Examples-----
      Sample Input 1:
      4 5 5
      2 1 1 1 2
      5 3 4 4 3
      4 3 3 3 2
      3 1 3 3 1
      Sample Output 1:
      6
      19 12 2 18 5 5

      Sample Input 2:
      3 3 3
      3 1 1
      1 3 2
      3 2 3
      Sample Output 2:
      13
      4 2 6 1 9 7 5 5 7 1 2 3 3

      Sample Input 3:
      3 2 2
      1 2
      2 1
      1 2
      Sample Output 3:
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
              "4 5 5\n2 1 1 1 2\n5 3 4 4 3\n4 3 3 3 2\n3 1 3 3 1\n",
              "6\n19 12 2 18 5 5\n"
          ],
          [
              "3 3 3\n3 1 1\n1 3 2\n3 2 3\n",
              "13\n4 2 6 1 9 7 5 5 7 1 2 3 3\n"
          ],
          [
              "3 2 2\n1 2\n2 1\n1 2\n",
              "-1\n"
          ],
          [
              "3 2 2\n2 1\n2 1\n1 1\n",
              "1\n6\n"
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
