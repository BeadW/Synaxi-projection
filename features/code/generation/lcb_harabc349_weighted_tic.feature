Feature: LiveCodeBench/atcoder/hard — Weighted Tic
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a 3 \times 3 grid. Let (i, j) denote the cell at the i-th row from the top and j-th column from the left (1 \leq i, j \leq 3). Cell (i, j) contains an integer A_{i,j}. It is guaranteed that \sum_{i=1}^3 \sum_{j=1}^3 A_{i,j} is odd. Additionally, all cells are initially painted white.
      Takahashi and Aoki will play a game using this grid. Takahashi goes first, and they take turns performing the following operation:

      - Choose a cell (i, j) (1\leq i, j \leq 3) that is still painted white (it can be shown that such a cell always exists at the time of the operation). The player performing the operation scores A_{i,j} points. Then, if the player is Takahashi, he paints the cell (i, j) red; if the player is Aoki, he paints it blue.

      After each operation, the following checks are made:

      - Check if there are three consecutive cells painted the same color (red or blue) in any row, column, or diagonal. If such a sequence exists, the game ends immediately, and the player whose color forms the sequence wins.
      - Check if there are white cells left. If no white cells remain, the game ends, and the player with the higher total score wins.

      It can be shown that the game will always end after a finite number of moves, and either Takahashi or Aoki will win. Determine which player wins if both play optimally for victory.

      Input

      The input is given from Standard Input in the following format:
      A_{1,1} A_{1,2} A_{1,3}
      A_{2,1} A_{2,2} A_{2,3}
      A_{3,1} A_{3,2} A_{3,3}

      Output

      If Takahashi wins, print Takahashi; if Aoki wins, print Aoki.

      Constraints


      - |A_{i,j}| \leq 10^9
      - \sum_{i=1}^3 \sum_{j=1}^3 A_{i,j} is odd.
      - All input values are integers.

      Sample Input 1

      0 0 0
      0 1 0
      0 0 0

      Sample Output 1

      Takahashi

      If Takahashi chooses cell (2,2) in his first move, no matter how Aoki plays afterward, Takahashi can always act to prevent three consecutive blue cells. If three consecutive red cells are formed, Takahashi wins. If the game ends without three consecutive red cells, at that

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "0 0 0\n0 1 0\n0 0 0\n",
              "Takahashi\n"
          ],
          [
              "-1 1 0\n-4 -2 -5\n-4 -1 -5\n",
              "Aoki\n"
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
