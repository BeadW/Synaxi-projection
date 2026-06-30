Feature: LiveCodeBench/atcoder/medium — A Piece of Cake
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a rectangular cake with some strawberries on the xy-plane. The cake occupies the rectangular area \lbrace (x, y) : 0 \leq x \leq W, 0 \leq y \leq H \rbrace.
      There are N strawberries on the cake, and the coordinates of the i-th strawberry are (p_i, q_i) for i = 1, 2, \ldots, N. No two strawberries have the same coordinates.
      Takahashi will cut the cake into several pieces with a knife, as follows.

      - First, cut the cake along A different lines parallel to the y-axis: lines x = a_1, x = a_2, \ldots, x = a_A.
      - Next, cut the cake along B different lines parallel to the x-axis: lines y = b_1, y = b_2, \ldots, y = b_B.

      As a result, the cake will be divided into (A+1)(B+1) rectangular pieces. Takahashi will choose just one of these pieces to eat. Print the minimum and maximum possible numbers of strawberries on the chosen piece.
      Here, it is guaranteed that there are no strawberries along the edges of the final pieces. For a more formal description, refer to the constraints below.

      Input

      The input is given from Standard Input in the following format:
      W H
      N
      p_1 q_1
      p_2 q_2
      \vdots
      p_N q_N
      A
      a_1 a_2 \ldots a_A
      B
      b_1 b_2 \ldots b_B

      Output

      Print the minimum possible number of strawberries m and the maximum possible number M on the chosen piece in the following format, separated by a space.
      m M

      Constraints


      - 3 \leq W, H \leq 10^9
      - 1 \leq N \leq 2 \times 10^5
      - 0 \lt p_i \lt W
      - 0 \lt q_i \lt H
      - i \neq j \implies (p_i, q_i) \neq (p_j, q_j)
      - 1 \leq A, B \leq 2 \times 10^5
      - 0 \lt a_1 \lt a_2 \lt \cdots \lt a_A \lt W
      - 0 \lt b_1 \lt b_2 \lt \cdots \lt b_B \lt H
      - p_i \not \in \lbrace a_1, a_2, \ldots, a_A \rbrace
      - q_i \not \in \lbrace b_1, b_2, \ldots, b_B \rbrace
      - All input values are integers.

      Sample Input 1

      7 6
      5
      6 1
      3 1
      4 2
      1 5
      6 2
      2
      2 5
      2
      3 4

      Sample Output 1

      0 2

      There are nine pieces in total: six with zero strawberries, one with one strawberry, and two with two strawberries. Therefore, when choosing just one of these pieces to eat, the minimum possibl

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "7 6\n5\n6 1\n3 1\n4 2\n1 5\n6 2\n2\n2 5\n2\n3 4\n",
              "0 2\n"
          ],
          [
              "4 4\n4\n1 1\n3 1\n3 3\n1 3\n1\n2\n1\n2\n",
              "1 1\n"
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
