Feature: LiveCodeBench/atcoder/hard — Abs Sum
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given integer sequences A=(A_1,A_2,\ldots,A_N) and B=(B_1,B_2,\ldots,B_N) of length N, and integer sequences X=(X_1,X_2,\ldots,X_K) and Y=(Y_1,Y_2,\ldots,Y_K) of length K.
      For each k=1,2,\ldots,K, find \displaystyle \sum_{i=1}^{X_k} \sum_{j=1}^{Y_k} |A_i-B_j|.

      Input

      The input is given from Standard Input in the following format:
      N
      A_1 A_2 \ldots A_N
      B_1 B_2 \ldots B_N
      K
      X_1 Y_1
      X_2 Y_2
      \vdots
      X_K Y_K

      Output

      Print K lines.
      The i-th line (1\le i\le K) should contain the answer for k=i.

      Constraints


      - 1\le N\le 10^5
      - 0\le A_i,B_j\le 2\times 10^8
      - 1\le K\le 10^4
      - 1\le X_k,Y_k\le N
      - All input values are integers.

      Sample Input 1

      2
      2 4
      3 5
      4
      1 1
      1 2
      2 1
      2 2

      Sample Output 1

      1
      4
      2
      6

      For k=1, the answer is |A_1-B_1|=1, so print 1 on the first line.
      For k=2, the answer is |A_1-B_1|+|A_1-B_2|=1+3=4, so print 4 on the second line.
      For k=3, the answer is |A_1-B_1|+|A_2-B_1|=1+1=2, so print 2 on the third line.
      For k=4, the answer is |A_1-B_1|+|A_1-B_2|+|A_2-B_1|+|A_2-B_2|=1+3+1+1=6, so print 6 on the fourth line.

      Sample Input 2

      5
      1163686 28892 1263085 2347878 520306
      1332157 1202905 2437161 1291976 563395
      5
      5 3
      1 5
      2 3
      1 2
      5 5

      Sample Output 2

      13331322
      2209746
      6366712
      207690
      20241215

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "2\n2 4\n3 5\n4\n1 1\n1 2\n2 1\n2 2",
              "1\n4\n2\n6"
          ],
          [
              "5\n1163686 28892 1263085 2347878 520306\n1332157 1202905 2437161 1291976 563395\n5\n5 3\n1 5\n2 3\n1 2\n5 5",
              "13331322\n2209746\n6366712\n207690\n20241215"
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
