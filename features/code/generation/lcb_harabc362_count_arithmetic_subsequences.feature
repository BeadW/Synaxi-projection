Feature: LiveCodeBench/atcoder/hard — Count Arithmetic Subsequences
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a sequence A = (A_1, A_2, \dots, A_N) of length N. For each k = 1, 2, \dots, N, find the number, modulo 998244353, of (not necessarily contiguous) subsequences of A of length k that are arithmetic sequences. Two subsequences are distinguished if they are taken from different positions, even if they are equal as sequences.

      What is a subsequence?
      A subsequence of a sequence A is a sequence obtained by deleting zero or more elements from A and arranging the remaining elements without changing the order.

      Input

      The input is given from Standard Input in the following format:
      N
      A_1 A_2 \dots A_N

      Output

      Print the answers for k = 1, 2, \dots, N in this order, in a single line, separated by spaces.

      Constraints


      - 1 \leq N \leq 80
      - 1 \leq A_i \leq 10^9
      - All input values are integers.

      Sample Input 1

      5
      1 2 3 2 3

      Sample Output 1

      5 10 3 0 0


      - There are 5 subsequences of length 1, all of which are arithmetic sequences.
      - There are 10 subsequences of length 2, all of which are arithmetic sequences.
      - There are 3 subsequences of length 3 that are arithmetic sequences: (A_1, A_2, A_3), (A_1, A_2, A_5), and (A_1, A_4, A_5).
      - There are no arithmetic subsequences of length 4 or more.

      Sample Input 2

      4
      1 2 3 4

      Sample Output 2

      4 6 2 1

      Sample Input 3

      1
      100

      Sample Output 3

      1

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5\n1 2 3 2 3\n",
              "5 10 3 0 0\n"
          ],
          [
              "4\n1 2 3 4\n",
              "4 6 2 1\n"
          ],
          [
              "1\n100\n",
              "1\n"
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
