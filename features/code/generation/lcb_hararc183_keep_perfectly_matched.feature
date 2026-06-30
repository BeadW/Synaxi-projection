Feature: LiveCodeBench/atcoder/hard — Keep Perfectly Matched
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a tree with N vertices numbered from 1 to N.
      The i-th edge connects vertices A_i and B_i.
      Here, N is even, and furthermore, this tree has a perfect matching.
      Specifically, for each i (1 \leq i \leq N/2), it is guaranteed that A_i=i \times 2-1 and B_i=i \times 2.
      You will perform the following operation N/2 times:

      - Choose two leaves (vertices with degree exactly 1) and remove them from the tree.
      Here, the tree after removal must still have a perfect matching.
      In this problem, we consider a graph with zero vertices to be a tree as well.

      For each operation, its score is defined as the distance between the two chosen vertices (the number of edges on the simple path connecting the two vertices).
      Show one procedure that maximizes the total score.
      It can be proved that there always exists a procedure to complete N/2 operations under the constraints of this problem.

      Input

      The input is given from Standard Input in the following format:
      N
      A_1 B_1
      A_2 B_2
      \vdots
      A_{N-1} B_{N-1}

      Output

      Print a solution in the following format:
      X_1 Y_1
      X_2 Y_2
      \vdots
      X_{N/2} Y_{N/2}

      Here, X_i and Y_i are the two vertices chosen in the i-th operation.
      If there are multiple solutions, you may print any of them.

      Constraints


      - 2 \leq N \leq 250000
      - N is even.
      - 1 \leq A_i < B_i \leq N (1 \leq i \leq N-1)
      - A_i=i \times 2 -1, B_i=i \times 2 (1 \leq i \leq N/2)
      - The given graph is a tree.
      - All input values are integers.

      Sample Input 1

      4
      1 2
      3 4
      2 3

      Sample Output 1

      4 1
      2 3

      The procedure in the sample output is as follows:

      - 1st operation: Remove vertices 4 and 1. The remaining tree has vertices 2 and 3, and a perfect matching. The score of this operation is 3.
      - 2nd operation: Remove vertices 2 and 3. The remaining tree has zero vertices and a perfect matching. The score of this operation is 1.
      - The total score is 3 + 1 = 4.

      It is impossible to make the total score greater than 4, so this output solves this sample input.

      Sample Input 2

      8
      1 2
      3 4
      5

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "4\n1 2\n3 4\n2 3\n",
              "4 1\n2 3\n"
          ],
          [
              "8\n1 2\n3 4\n5 6\n7 8\n2 3\n1 5\n1 7\n",
              "4 8\n7 6\n5 3\n2 1\n"
          ],
          [
              "14\n1 2\n3 4\n5 6\n7 8\n9 10\n11 12\n13 14\n2 8\n4 11\n5 12\n7 13\n11 14\n9 13\n",
              "1 6\n5 2\n8 12\n3 7\n10 4\n11 9\n13 14\n"
          ],
          [
              "20\n1 2\n3 4\n5 6\n7 8\n9 10\n11 12\n13 14\n15 16\n17 18\n19 20\n8 10\n16 18\n16 19\n5 9\n10 17\n2 13\n7 14\n3 7\n3 12\n",
              "6 1\n2 15\n20 13\n14 19\n16 4\n11 18\n17 12\n3 5\n9 7\n8 10\n"
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
