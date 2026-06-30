Feature: LiveCodeBench/atcoder/medium — World Tour Finals
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      The programming contest World Tour Finals is underway, where N players are participating, and half of the competition time has passed.
      There are M problems in this contest, and the score A_i of problem i is a multiple of 100 between 500 and 2500, inclusive.
      For each i = 1, \ldots, N, you are given a string S_i that indicates which problems player i has already solved.
      S_i is a string of length M consisting of o and x, where the j-th character of S_i is o if player i has already solved problem j, and x if they have not yet solved it.
      Here, none of the players have solved all the problems yet.
      The total score of player i is calculated as the sum of the scores of the problems they have solved, plus a bonus score of i points.
      For each i = 1, \ldots, N, answer the following question.

      - At least how many of the problems that player i has not yet solved must player i solve to exceed all other players' current total scores?

      Note that under the conditions in this statement and the constraints, it can be proved that player i can exceed all other players' current total scores by solving all the problems, so the answer is always defined.

      Input

      The input is given from Standard Input in the following format:
      N M
      A_1 A_2 \ldots A_M
      S_1
      S_2
      \vdots
      S_N

      Output

      Print N lines. The i-th line should contain the answer to the question for player i.

      Constraints


      - 2\leq N\leq 100
      - 1\leq M\leq 100
      - 500\leq A_i\leq 2500
      - A_i is a multiple of 100.
      - S_i is a string of length M consisting of o and x.
      - S_i contains at least one x.
      - All numeric values in the input are integers.

      Sample Input 1

      3 4
      1000 500 700 2000
      xxxo
      ooxx
      oxox

      Sample Output 1

      0
      1
      1

      The players' total scores at the halfway point of the competition time are 2001 points for player 1, 1502 points for player 2, and 1703 points for player 3.
      Player 1 is already ahead of all other players' total scores without solving any more problems.
      Player 2 can, for example, solve problem 4 to have a total score of 3502 points,

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 4\n1000 500 700 2000\nxxxo\nooxx\noxox\n",
              "0\n1\n1\n"
          ],
          [
              "5 5\n1000 1500 2000 2000 2500\nxxxxx\noxxxx\nxxxxx\noxxxx\noxxxx\n",
              "1\n1\n1\n1\n0\n"
          ],
          [
              "7 8\n500 500 500 500 500 500 500 500\nxxxxxxxx\noxxxxxxx\nooxxxxxx\noooxxxxx\nooooxxxx\noooooxxx\nooooooxx\n",
              "7\n6\n5\n4\n3\n2\n0\n"
          ]
      ]


      def test_lcb():
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

  Scenario: Agent solves the LiveCodeBench problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py to read from stdin and write the correct answer to stdout so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
