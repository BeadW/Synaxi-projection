Feature: LiveCodeBench/atcoder/hard — No Cross Matching
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There are 2N points P_1,P_2,\ldots,P_N, Q_1,Q_2,\ldots,Q_N on a two-dimensional plane.
      The coordinates of P_i are (A_i, B_i), and the coordinates of Q_i are (C_i, D_i).
      No three different points lie on the same straight line.
      Determine whether there exists a permutation R = (R_1, R_2, \ldots, R_N) of (1, 2, \ldots, N) that satisfies the following condition. If such an R exists, find one.

      - For each integer i from 1 through N, let segment i be the line segment connecting P_i and Q_{R_i}.  Then, segment i and segment j (1 \leq  i < j \leq N) never intersect.

      Input

      The input is given from Standard Input in the following format:
      N
      A_1 B_1
      A_2 B_2
      \vdots 
      A_N B_N
      C_1 D_1
      C_2 D_2
      \vdots
      C_N D_N

      Output

      If there is no R satisfying the condition, print -1.
      If such an R exists, print R_1, R_2, \ldots, R_N separated by spaces. If there are multiple solutions, you may print any of them.

      Constraints


      - 1 \leq N \leq 300
      - 0 \leq A_i, B_i, C_i, D_i \leq 5000 (1 \leq i \leq N)
      - (A_i, B_i) \neq (A_j, B_j) (1 \leq i < j \leq N)
      - (C_i, D_i) \neq (C_j, D_j) (1 \leq i < j \leq N)
      - (A_i, B_i) \neq (C_j, D_j) (1 \leq i, j \leq N)
      - No three different points lie on the same straight line.
      - All input values are integers.

      Sample Input 1

      3
      0 0
      2 4
      4 2
      0 2
      2 0
      4 4

      Sample Output 1

      2 1 3

      The points are arranged as shown in the following figure.

      By setting R = (2, 1, 3), the three line segments do not cross each other. Also, any of R = (1, 2, 3), (1, 3, 2), (2, 3, 1), and (3, 1, 2) is a valid answer.

      Sample Input 2

      8
      59 85
      60 57
      72 12
      3 27
      16 58
      41 94
      77 64
      97 20
      32 37
      7 2
      57 94
      35 70
      38 60
      97 100
      5 76
      38 8

      Sample Output 2

      3 5 8 2 7 4 6 1

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n0 0\n2 4\n4 2\n0 2\n2 0\n4 4\n",
              "2 1 3\n"
          ],
          [
              "8\n59 85\n60 57\n72 12\n3 27\n16 58\n41 94\n77 64\n97 20\n32 37\n7 2\n57 94\n35 70\n38 60\n97 100\n5 76\n38 8\n",
              "3 5 8 2 7 4 6 1\n"
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
