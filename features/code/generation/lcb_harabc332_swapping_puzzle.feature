Feature: LiveCodeBench/atcoder/hard — Swapping Puzzle
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given two grids, A and B, each with H rows and W columns.
      For each pair of integers (i, j) satisfying 1 \leq i \leq H and 1 \leq j \leq W, let (i, j) denote the cell in the i-th row and j-th column. In grid A, cell (i, j) contains the integer A_{i, j}. In grid B, cell (i, j) contains the integer B_{i, j}.
      You will repeat the following operation any number of times, possibly zero. In each operation, you perform one of the following:

      - Choose an integer i satisfying 1 \leq i \leq H-1 and swap the i-th and (i+1)-th rows in grid A.
      - Choose an integer i satisfying 1 \leq i \leq W-1 and swap the i-th and (i+1)-th columns in grid A.

      Determine whether it is possible to make grid A identical to grid B by repeating the above operation. If it is possible, print the minimum number of operations required to do so.
      Here, grid A is identical to grid B if and only if, for all pairs of integers (i, j) satisfying 1 \leq i \leq H and 1 \leq j \leq W, the integer written in cell (i, j) of grid A is equal to the integer written in cell (i, j) of grid B.

      Input

      The input is given from Standard Input in the following format:
      H W
      A_{1, 1} A_{1, 2} \cdots A_{1, W}
      A_{2, 1} A_{2, 2} \cdots A_{2, W}
      \vdots
      A_{H, 1} A_{H, 2} \cdots A_{H, W}
      B_{1, 1} B_{1, 2} \cdots B_{1, W}
      B_{2, 1} B_{2, 2} \cdots B_{2, W}
      \vdots
      B_{H, 1} B_{H, 2} \cdots B_{H, W}

      Output

      If it is impossible to make grid A identical to grid B, output -1. Otherwise, print the minimum number of operations required to make grid A identical to grid B.

      Constraints


      - All input values are integers.
      - 2 \leq H, W \leq 5
      - 1 \leq A_{i, j}, B_{i, j} \leq 10^9

      Sample Input 1

      4 5
      1 2 3 4 5
      6 7 8 9 10
      11 12 13 14 15
      16 17 18 19 20
      1 3 2 5 4
      11 13 12 15 14
      6 8 7 10 9
      16 18 17 20 19

      Sample Output 1

      3

      Swapping the fourth and fifth columns of the initial grid A yields the following grid:
      1 2 3 5 4
      6 7 8 10 9
      11 12 13 15 14
      16 17 18 20 19

      Then, swapping the second and third rows yields the following grid:
      1 2 3 5 4
      11 12 1

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "4 5\n1 2 3 4 5\n6 7 8 9 10\n11 12 13 14 15\n16 17 18 19 20\n1 3 2 5 4\n11 13 12 15 14\n6 8 7 10 9\n16 18 17 20 19\n",
              "3\n"
          ],
          [
              "2 2\n1 1\n1 1\n1 1\n1 1000000000\n",
              "-1\n"
          ],
          [
              "3 3\n8 1 6\n3 5 7\n4 9 2\n8 1 6\n3 5 7\n4 9 2\n",
              "0\n"
          ],
          [
              "5 5\n710511029 136397527 763027379 644706927 447672230\n979861204 57882493 442931589 951053644 152300688\n43971370 126515475 962139996 541282303 834022578\n312523039 506696497 664922712 414720753 304621362\n325269832 191410838 286751784 732741849 806602693\n806602693 732741849 286751784 191410838 325269832\n304621362 414720753 664922712 506696497 312523039\n834022578 541282303 962139996 126515475 43971370\n152300688 951053644 442931589 57882493 979861204\n447672230 644706927 763027379 136397527 710511029\n",
              "20\n"
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
