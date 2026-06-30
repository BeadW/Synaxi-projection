Feature: LiveCodeBench/atcoder/hard — Train Delay
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      In the nation of Atcoder, there are N cities numbered 1 to N, and M trains numbered 1 to M.
      Train i departs from city A_i at time S_i and arrives at city B_i at time T_i.
      Given a positive integer X_1, find a way to set non-negative integers X_2,\ldots,X_M that satisfies the following condition with the minimum possible value of X_2+\ldots+X_M.

      - Condition: For all pairs (i,j) satisfying 1 \leq i,j \leq M, if B_i=A_j and T_i \leq S_j, then T_i+X_i \leq S_j+X_j.
      - In other words, for any pair of trains that are originally possible to transfer between, it is still possible to transfer even after delaying the departure and arrival times of each train i by X_i.



      It can be proved that such a way to set X_2,\ldots,X_M with the minimum possible value of X_2+\ldots+X_M is unique.

      Input

      The input is given from Standard Input in the following format:
      N M X_1
      A_1 B_1 S_1 T_1
      \vdots
      A_M B_M S_M T_M

      Output

      Print X_2,\ldots,X_M that satisfy the condition with the minimum possible sum, in that order, separated by spaces.

      Constraints


      - 2 \leq N \leq 2\times 10^5
      - 2 \leq M \leq 2\times 10^5
      - 1 \leq A_i,B_i \leq N
      - A_i \neq B_i
      - 0 \leq S_i < T_i \leq 10^9
      - 1 \leq X_1 \leq 10^9
      - All input values are integers.

      Sample Input 1

      3 6 15
      1 2 10 20
      1 2 20 30
      2 3 25 40
      2 3 35 50
      3 1 15 30
      3 1 45 60

      Sample Output 1

      0 10 0 0 5

      The arrival of train 1 from city 1 to 2 is delayed by 15 and becomes time 35.
      To allow transfer from train 1 to 3 in city 2, the departure of train 3 is delayed by 10, making it depart at time 35 and arrive at time 50.
      Further, to allow transfer from train 3 to 6 in city 3, the departure of train 6 is delayed by 5, making it depart at time 50.
      Other trains can operate without delay while still allowing transfers between originally transferable trains, so (X_2,X_3,X_4,X_5,X_6)=(0,10,0,0,5) satisfies the condition.
      Moreover, there is no solution with a smaller sum that satisfies the condition, so this is the answer.

      Sample Input 2

      10 9 10

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 6 15\n1 2 10 20\n1 2 20 30\n2 3 25 40\n2 3 35 50\n3 1 15 30\n3 1 45 60\n",
              "0 10 0 0 5\n"
          ],
          [
              "10 9 100\n1 10 0 1\n10 2 1 100\n10 3 1 100\n10 4 1 100\n10 5 1 100\n10 6 1 100\n10 7 1 100\n10 8 1 100\n10 9 1 100\n",
              "100 100 100 100 100 100 100 100\n"
          ],
          [
              "4 4 10\n1 2 0 1\n1 2 0 10\n2 3 100 200\n2 4 100 200\n",
              "0 0 0\n"
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
