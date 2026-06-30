Feature: LiveCodeBench/atcoder/hard — Basic Grid Problem with Updates
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is an H \times W grid. Let (h,w) denote the cell at the h-th row from the top and the w-th column from the left. A non-negative integer A_{h,w} is written in cell (h,w).
      Takahashi starts at cell (sh,sw) and will perform Q changes to the grid. The i-th change is given by a character d_i (d_i is one of L, R, U, D) and a non-negative integer a_i, meaning Takahashi will do the following:

      - Move one cell in the direction d_i. That is, if d_i is L, move left; if R, move right; if U, move up; if D, move down by one cell. Then, let the destination cell be (h,w), and set A_{h,w} to a_i.

      It is guaranteed that in each change, he can move one cell in direction d_i.
      After each change, print the answer to the following problem:

      A sequence of cells P = ((h_1,w_1), \ldots, (h_{M},w_{M})) is said to be a path if and only if it satisfies all of the following conditions:

      - (h_1,w_1) = (1,1), (h_{M},w_{M}) = (H,W), and M = H + W - 1.
      - For every i with 1 \leq i \leq M-1, either (h_{i+1}, w_{i+1}) = (h_i + 1, w_i) or (h_{i+1}, w_{i+1}) = (h_i, w_i + 1).

      There are \binom{H+W-2}{H-1} paths. For a path P = ((h_1,w_1), \ldots, (h_{M},w_{M})), define f(P) = \prod_{1\leq i\leq M}A_{h_i,w_i}. Print the sum, modulo 998244353, of f(P) over all paths P.

      Input

      The input is given from Standard Input in the following format:
      H W
      A_{1,1} \cdots A_{1,W}
      \vdots
      A_{H,1} \cdots A_{H,W}
      Q sh sw
      d_1 a_1
      \vdots
      d_Q a_Q

      Output

      Print Q lines.
      The i-th line should contain the sum, modulo 998244353, of f(P) over all paths P after performing the i-th change to the grid.

      Constraints


      - 2 \leq H, W \leq 200000
      - HW \leq 200000
      - 0 \leq A_{h,w} < 998244353
      - 1 \leq Q \leq 200000
      - 1 \leq sh \leq H, 1 \leq sw \leq W
      - 0 \leq a_i < 998244353
      - H, W, A_{h,w}, Q, sh, sw, and a_i are integers.
      - Each d_i is L, R, U, or D.
      - In each change, Takahashi can move one cell in the direction d_i.

      Sample Input 1

      2 3
      1 2 3
      4 5 6
      3 2 2
      U 7
      R 8
      L 9

      Sample Output 1

      456
      666
      822


      - Initially, Takahashi is at (2,2

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "2 3\n1 2 3\n4 5 6\n3 2 2\nU 7\nR 8\nL 9",
              "456\n666\n822"
          ],
          [
              "5 4\n147015809 294958521 852121867 499798308\n790350368 404692331 645419803 290531806\n275766153 896286651 239187926 945049742\n340760022 236352314 926236110 223464913\n287023679 590772036 340282357 521075891\n6 3 1\nU 344644511\nR 45812235\nD 260083498\nR 781118585\nL 156297846\nL 411901560",
              "299123226\n548055393\n810247224\n876210800\n773990840\n506814544"
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
