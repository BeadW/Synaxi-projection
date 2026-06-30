Feature: LiveCodeBench/atcoder/hard — Dense Buildings
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a city divided into H \times W blocks in the north-south-east-west directions, and there is exactly one building in each block.
      Specifically, in the block at the i-th row from the north (1\leq i\leq H) and the j-th column from the west (1\leq j\leq W) (hereafter referred to as block (i,j)), there is a building of F_{i,j} floors.
      Takahashi has two ways of moving. If he is on the X-th floor (1\leq X\leq F_{i,j}) of the building in block (i,j), he can:

      - Move up or down one floor within the same building using stairs. If X=1, he cannot move down; if X=F_{i,j}, he cannot move up.
      - Choose a building with at least X floors in a cardinally adjacent block, and move to the X-th floor of that building using a (sky) walkway.

      Here, two blocks (i,j) and (i',j') are cardinally adjacent if and only if \lvert i - i'\rvert + \lvert j - j'\rvert = 1.
      You are given Q queries to be answered. The i-th query (1\leq i\leq Q) is the following.

      Find the minimum possible number of times that Takahashi uses stairs to move from the Y_i-th floor of the building in block (A_i,B_i) to the Z_i-th floor of the building in block (C_i,D_i).
      The count of times using stairs is incremented each time he moves up or down one floor, possibly multiple times within the same building. (For example, moving from the 1st floor to the 6th floor of a building counts as 5 uses of stairs.)
      Note that he does not have to minimize the number of times he uses walkways.

      Input

      The input is given from Standard Input in the following format:
      H W
      F_{1,1} F_{1,2} \ldots F_{1,W}
      F_{2,1} F_{2,2} \ldots F_{2,W}
      \vdots
      F_{H,1} F_{H,2} \ldots F_{H,W}
      Q
      A_1 B_1 Y_1 C_1 D_1 Z_1
      A_2 B_2 Y_2 C_2 D_2 Z_2
      \vdots
      A_Q B_Q Y_Q C_Q D_Q Z_Q

      Output

      Print Q lines. The i-th line should contain the answer to the i-th query as an integer.

      Constraints


      - 1\leq H \leq 500
      - 1\leq W \leq 500
      - 1\leq F_{i,j} \leq 10^6
      - 1\leq Q\leq 2\times 10^5
      - 1\leq A_i,C_i\leq H
      - 1\leq B_i,D_i\leq W
      - 1\leq Y_i\leq F_{A_i,B_i}
      - 1\leq Z_i\leq 

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 3\n12 10 6\n1 1 3\n8 6 7\n2\n1 1 10 3 1 6\n1 1 6 1 2 4",
              "10\n2"
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
