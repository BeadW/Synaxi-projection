Feature: LiveCodeBench/atcoder/medium — Dash
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      On a two-dimensional plane, Takahashi is initially at point (0, 0), and his initial health is H.  M items to recover health are placed on the plane; the i-th of them is placed at (x_i,y_i).
      Takahashi will make N moves.  The i-th move is as follows.

      - 
      Let (x,y) be his current coordinates.  He consumes a health of 1 to move to the following point, depending on S_i, the i-th character of S:

      - (x+1,y) if S_i is R;
      - (x-1,y) if S_i is L;
      - (x,y+1) if S_i is U;
      - (x,y-1) if S_i is D.


      - 
      If Takahashi's health has become negative, he collapses and stops moving.  Otherwise, if an item is placed at the point he has moved to, and his health is strictly less than K, then he consumes the item there to make his health K.


      Determine if Takahashi can complete the N moves without being stunned.

      Input

      The input is given from Standard Input in the following format:
      N M H K
      S
      x_1 y_1
      \vdots
      x_M y_M

      Output

      Print Yes if he can complete the N moves without being stunned; print No otherwise.

      Constraints


      - 1\leq N,M,H,K\leq 2\times 10^5
      - S is a string of length N consisting of R, L, U, and D.
      - |x_i|,|y_i| \leq 2\times 10^5
      - (x_i, y_i) are pairwise distinct.
      - All values in the input are integers, except for S.

      Sample Input 1

      4 2 3 1
      RUDL
      -1 -1
      1 0

      Sample Output 1

      Yes

      Initially, Takahashi's health is 3.  We describe the moves below.

      - 
      1-st move: S_i is R, so he moves to point (1,0).  His health reduces to 2.  Although an item is placed at point (1,0), he do not consume it because his health is no less than K=1.

      - 
      2-nd move: S_i is U, so he moves to point (1,1).  His health reduces to 1.

      - 
      3-rd move: S_i is D, so he moves to point (1,0).  His health reduces to 0.  An item is placed at point (1,0), and his health is less than K=1, so he consumes the item to make his health 1.

      - 
      4-th move: S_i is L, so he moves to point (0,0).  His health reduces to 0.


      Thus, he can make the 4 moves without collapsing, so Yes should be printed.  Note that the health may reach 0.

      S

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "4 2 3 1\nRUDL\n-1 -1\n1 0\n",
              "Yes\n"
          ],
          [
              "5 2 1 5\nLDRLD\n0 0\n-1 -1\n",
              "No\n"
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
