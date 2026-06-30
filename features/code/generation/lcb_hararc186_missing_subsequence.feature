Feature: LiveCodeBench/atcoder/hard — Missing Subsequence
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a sequence of integers (X_1,\dots,X_M) of length M consisting of 1,\dots,K.
      Find the number of sequences (A_1,\dots,A_N) of length N consisting of 1,\dots,K that satisfy the following condition, modulo 998244353:

      - Among all sequences of length M consisting of 1,\dots,K, the only sequence that cannot be obtained as a (not necessarily contiguous) subsequence of (A_1,\dots,A_N) is (X_1,\dots,X_M).

      Input

      The input is given from Standard Input in the following format:
      N M K
      X_1 X_2 \dots X_M

      Output

      Print the number of sequences satisfying the condition, modulo 998244353.

      Constraints


      - 2\le M,K \le N \le 400
      - 1\le X_i \le K
      - All input values are integers.

      Sample Input 1

      5 2 3
      1 1

      Sample Output 1

      4

      The following four sequences satisfy the condition:

      - (2, 3, 1, 2, 3)
      - (2, 3, 1, 3, 2)
      - (3, 2, 1, 2, 3)
      - (3, 2, 1, 3, 2)

      Sample Input 2

      400 3 9
      1 8 6

      Sample Output 2

      417833302

      Sample Input 3

      29 3 10
      3 3 3

      Sample Output 3

      495293602

      Sample Input 4

      29 3 10
      3 3 4

      Sample Output 4

      0

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5 2 3\n1 1",
              "4"
          ],
          [
              "400 3 9\n1 8 6",
              "417833302"
          ],
          [
              "29 3 10\n3 3 3",
              "495293602"
          ],
          [
              "29 3 10\n3 3 4",
              "0"
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
