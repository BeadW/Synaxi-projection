Feature: LiveCodeBench/atcoder/hard — Shortcuts
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a race through checkpoints 1,2,\dots,N in this order on a coordinate plane.
      The coordinates of checkpoint i are (X_i,Y_i), and all checkpoints have different coordinates.
      Checkpoints other than checkpoints 1 and N can be skipped.
      However, let C be the number of checkpoints skipped, and the following penalty will be imposed:

      - \displaystyle 2^{C−1} if C>0, and
      - 0 if C=0.

      Let s be the total distance traveled (Euclidean distance) from checkpoint 1 to checkpoint N plus the penalty.
      Find the minimum achievable value as s.

      Input

      The input is given from Standard Input in the following format:
      N
      X_1 Y_1
      X_2 Y_2
      \vdots
      X_N Y_N

      Output

      Print the answer. Your output is considered correct if the absolute or relative error from the true value is at most 10^{-5}.

      Constraints


      - All input values are integers.
      - 2 \le N \le 10^4
      - 0 \le X_i,Y_i \le 10^4
      - (X_i,Y_i) \neq (X_j,Y_j) if i \neq j.

      Sample Input 1

      6
      0 0
      1 1
      2 0
      0 1
      1 0
      2 1

      Sample Output 1

      5.82842712474619009753

      Consider passing through checkpoints 1,2,5,6 and skip checkpoints 3,4.

      - Move from checkpoint 1 to 2. The distance between them is \sqrt{2}.
      - Move from checkpoint 2 to 5. The distance between them is 1.
      - Move from checkpoint 5 to 6. The distance between them is \sqrt{2}.
      - Two checkpoints are skipped, so the penalty of 2 is imposed.

      In this way, you can achieve s = 3 + 2\sqrt{2} \approx 5.828427.
      You cannot make s smaller than this value.

      Sample Input 2

      10
      1 8
      3 7
      9 4
      4 9
      6 1
      7 5
      0 0
      1 3
      6 8
      6 4

      Sample Output 2

      24.63441361516795872523

      Sample Input 3

      10
      34 24
      47 60
      30 31
      12 97
      87 93
      64 46
      82 50
      14 7
      17 24
      3 78

      Sample Output 3

      110.61238353245736230207

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "6\n0 0\n1 1\n2 0\n0 1\n1 0\n2 1\n",
              "5.82842712474619009753\n"
          ],
          [
              "10\n1 8\n3 7\n9 4\n4 9\n6 1\n7 5\n0 0\n1 3\n6 8\n6 4\n",
              "24.63441361516795872523\n"
          ],
          [
              "10\n34 24\n47 60\n30 31\n12 97\n87 93\n64 46\n82 50\n14 7\n17 24\n3 78\n",
              "110.61238353245736230207\n"
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
