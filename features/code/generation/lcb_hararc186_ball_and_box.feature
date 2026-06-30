Feature: LiveCodeBench/atcoder/hard — Ball and Box
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Mr. Ball and Mr. Box will play a game with balls and boxes.
      Initially, Mr. Ball has 10^{100} balls of each of M different types, and Mr. Box has 10^{100} yen.
      There are N boxes, where the i-th box has capacity V_i and costs P_i yen. During the game, Mr. Box can buy any box at any time.
      In this game, the following operations are repeated until the game ends:

      - Mr. Ball chooses one ball and gives it to Mr. Box.
      - Mr. Box either accepts the ball or ends the game without accepting it.
      - If Mr. Box accepts the ball, he chooses one of his purchased boxes and puts the ball in it.
      - If the box with the ball satisfies the following conditions, Mr. Box receives 1 yen. Otherwise, the game ends.
      - The number of balls in the box does not exceed its capacity.
      - All balls in the box are of the same type.



      Mr. Ball will play optimally to minimize Mr. Box's final money, while Mr. Box will play optimally to maximize it.
      How much will Mr. Box's money increase throughout the game?
      Here, both players have access to all information. In particular, Mr. Ball can see the capacity, price, and contents (type and number of balls) of each box.
      Also, note that Mr. Box's initial money is large enough that he will never run out of money to buy boxes.
      Solve T test cases for each input file.

      Input

      The input is given from Standard Input in the following format, where \mathrm{case}_i represents the i-th test case:
      T
      \mathrm{case}_1
      \mathrm{case}_2
      \vdots
      \mathrm{case}_T

      Each test case is given in the following format:
      N M
      V_1 P_1
      V_2 P_2
      \vdots
      V_N P_N

      Output

      Print the difference between Mr. Box's final and initial money when both players play optimally.

      Constraints


      - 1\le T,N,M\le 3\times 10^5
      - 1\le V_i,P_i \le 10^9
      - The sum of N over the T test cases is at most 3\times 10^5.
      - All input values are integers.

      Sample Input 1

      3
      3 2
      1 1000000000
      3 1
      3 1
      1 300000
      1000000000 1
      10 4
      22 5
      26 45
      72 21
      47 39
      97 2
      75 35
      82 24
      17 46
      32 22
      28 67

      Sample Output 1

      2
      0
      28

      In the first test case, the

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n3 2\n1 1000000000\n3 1\n3 1\n1 300000\n1000000000 1\n10 4\n22 5\n26 45\n72 21\n47 39\n97 2\n75 35\n82 24\n17 46\n32 22\n28 67",
              "2\n0\n28"
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
              assert r.stdout.strip() == expected.strip(), (
                  f"Case {i}: expected {expected!r}, got {r.stdout!r}"
              )

      """

  Scenario: Agent solves the LiveCodeBench problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
