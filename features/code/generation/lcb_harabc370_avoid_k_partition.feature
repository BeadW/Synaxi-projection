Feature: LiveCodeBench/atcoder/hard — Avoid K Partition
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a sequence A = (A_1, A_2, \dots, A_N) of length N and an integer K.
      There are 2^{N-1} ways to divide A into several contiguous subsequences. How many of these divisions have no subsequence whose elements sum to K? Find the count modulo 998244353.
      Here, "to divide A into several contiguous subsequences" means the following procedure.

      - Freely choose the number k (1 \leq k \leq N) of subsequences and an integer sequence (i_1, i_2, \dots, i_k, i_{k+1}) satisfying 1 = i_1 \lt i_2 \lt \dots \lt i_k \lt i_{k+1} = N+1.
      - For each 1 \leq n \leq k, the n-th subsequence is formed by taking the i_n-th through (i_{n+1} - 1)-th elements of A, maintaining their order.

      Here are some examples of divisions for A = (1, 2, 3, 4, 5):

      - (1, 2, 3), (4), (5)
      - (1, 2), (3, 4, 5)
      - (1, 2, 3, 4, 5)

      Input

      The input is given from Standard Input in the following format:
      N K
      A_1 A_2 \dots A_N

      Output

      Print the count modulo 998244353.

      Constraints


      - 1 \leq N \leq 2 \times 10^5
      - -10^{15} \leq K \leq 10^{15}
      - -10^9 \leq A_i \leq 10^9
      - All input values are integers.

      Sample Input 1

      3 3
      1 2 3

      Sample Output 1

      2

      There are two divisions that satisfy the condition in the problem statement:

      - (1), (2, 3)
      - (1, 2, 3)

      Sample Input 2

      5 0
      0 0 0 0 0

      Sample Output 2

      0

      Sample Input 3

      10 5
      -5 -1 -7 6 -6 -2 -5 10 2 -10

      Sample Output 3

      428

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 3\n1 2 3\n",
              "2\n"
          ],
          [
              "5 0\n0 0 0 0 0\n",
              "0\n"
          ],
          [
              "10 5\n-5 -1 -7 6 -6 -2 -5 10 2 -10\n",
              "428\n"
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
