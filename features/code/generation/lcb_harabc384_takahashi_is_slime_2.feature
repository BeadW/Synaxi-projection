Feature: LiveCodeBench/atcoder/hard — Takahashi is Slime 2
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a grid with H horizontal rows and W vertical columns.
      Let (i, j) denote the cell at the i-th row (1\leq i\leq H) from the top and j-th column (1\leq j\leq W) from the left.
      Initially, there is a slime with strength S _ {i,j} in cell (i,j), and Takahashi is the slime in the cell (P,Q).
      Find the maximum possible strength of Takahashi after performing the following action any number of times (possibly zero):

      - Among the slimes adjacent to him, choose one whose strength is strictly less than \dfrac{1}{X} times his strength and absorb it.
        As a result, the absorbed slime disappears, and Takahashi's strength increases by the strength of the absorbed slime.

      When performing the above action, the gap left by the disappeared slime is immediately filled by Takahashi, and the slimes that were adjacent to the disappeared one (if any) become newly adjacent to Takahashi (refer to the explanation in sample 1).

      Input

      The input is given in the following format from Standard Input:
      H W X 
      P Q
      S _ {1,1} S _ {1,2} \ldots S _ {1,W}
      S _ {2,1} S _ {2,2} \ldots S _ {2,W}
      \vdots
      S _ {H,1} S _ {H,2} \ldots S _ {H,W}

      Output

      Print the maximum possible strength of Takahashi after performing the action.

      Constraints


      - 1\leq H,W\leq500
      - 1\leq P\leq H
      - 1\leq Q\leq W
      - 1\leq X\leq10^9
      - 1\leq S _ {i,j}\leq10^{12}
      - All input values are integers.

      Sample Input 1

      3 3 2
      2 2
      14 6 9
      4 9 20
      17 15 7

      Sample Output 1

      28

      Initially, the strength of the slime in each cell is as follows:

      For example, Takahashi can act as follows:


      - Absorb the slime in cell (2,1). His strength becomes 9+4=13, and the slimes in cells (1,1) and (3,1) become newly adjacent to him.
      - Absorb the slime in cell (1,2). His strength becomes 13+6=19, and the slime in cell (1,3) becomes newly adjacent to him.
      - Absorb the slime in cell (1,3). His strength becomes 19+9=28.

      After these actions, his strength is 28.
      No matter how he acts, it is impossible to get a strength greater than 28, so print 28.
      No

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 3 2\n2 2\n14 6 9\n4 9 20\n17 15 7",
              "28"
          ],
          [
              "3 4 1\n1 1\n5 10 1 1\n10 1 1 1\n1 1 1 1",
              "5"
          ],
          [
              "8 10 2\n1 5\n388 130 971 202 487 924 247 286 237 316\n117 166 918 106 336 928 493 391 235 398\n124 280 425 955 212 988 227 222 307 226\n336 302 478 246 950 368 291 236 170 101\n370 200 204 141 287 410 388 314 205 460\n291 104 348 337 404 399 416 263 415 339\n105 420 302 334 231 481 466 366 401 452\n119 432 292 403 371 417 351 231 482 184",
              "1343"
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
