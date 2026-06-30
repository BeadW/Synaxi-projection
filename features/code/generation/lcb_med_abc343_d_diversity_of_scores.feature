Feature: LiveCodeBench/atcoder/medium — Diversity of Scores
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Takahashi is hosting a contest with N players numbered 1 to N. 
      The players will compete for points. Currently, all players have zero points.
      Takahashi's foreseeing ability lets him know how the players' scores will change. Specifically, for i=1,2,\dots,T, the score of player A_i will increase by B_i points at i seconds from now. There will be no other change in the scores.
      Takahashi, who prefers diversity in scores, wants to know how many different score values will appear among the players' scores at each moment. For each i=1,2,\dots,T, find the number of different score values among the players' scores at i+0.5 seconds from now.
      For example, if the players have 10, 20, 30, and 20 points at some moment, there are three different score values among the players' scores at that moment.

      Input

      The input is given from Standard Input in the following format:
      N T
      A_1 B_1
      A_2 B_2
      \vdots
      A_T B_T

      Output

      Print T lines.
      The i-th line (1\leq i \leq T) should contain an integer representing the number of different score values among the players' scores at i+0.5 seconds from now.

      Constraints


      - 1\leq N, T\leq 2\times 10^5
      - 1\leq A_i \leq N
      - 1\leq B_i \leq 10^9
      - All input values are integers.

      Sample Input 1

      3 4
      1 10
      3 20
      2 10
      2 10

      Sample Output 1

      2
      3
      2
      2

      Let S be the sequence of scores of players 1, 2, 3 in this order.
      Currently, S=\lbrace 0,0,0\rbrace.

      - After one second, the score of player 1 increases by 10 points, making S=\lbrace 10,0,0\rbrace. Thus, there are two different score values among the players' scores at 1.5 seconds from now.
      - After two seconds, the score of player 3 increases by 20 points, making S=\lbrace 10,0,20\rbrace. Thus, there are three different score values among the players' scores at 2.5 seconds from now.
      - After three seconds, the score of player 2 increases by 10 points, making S=\lbrace 10,10,20\rbrace. Therefore, there are two different score values among the players' scores at 3.5 seconds from now.
      - After four seconds, the score of

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 4\n1 10\n3 20\n2 10\n2 10\n",
              "2\n3\n2\n2\n"
          ],
          [
              "1 3\n1 3\n1 4\n1 3\n",
              "1\n1\n1\n"
          ],
          [
              "10 10\n7 2620\n9 2620\n8 3375\n1 3375\n6 1395\n5 1395\n6 2923\n10 3375\n9 5929\n5 1225\n",
              "2\n2\n3\n3\n4\n4\n5\n5\n6\n5\n"
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
