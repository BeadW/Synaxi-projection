Feature: LiveCodeBench/atcoder/hard — Permutation Subsequence
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a permutation P = (P_1, P_2, \dots, P_N) of (1, 2, \dots, N).
      A length-K sequence of indices (i_1, i_2, \dots, i_K) is called a good index sequence if it satisfies both of the following conditions:

      - 1 \leq i_1 < i_2 < \dots < i_K \leq N.
      - The subsequence (P_{i_1}, P_{i_2}, \dots, P_{i_K}) can be obtained by rearranging some consecutive K integers.
      Formally, there exists an integer a such that \lbrace P_{i_1},P_{i_2},\dots,P_{i_K} \rbrace = \lbrace a,a+1,\dots,a+K-1 \rbrace.

      Find the minimum value of i_K - i_1 among all good index sequences. It can be shown that at least one good index sequence exists under the constraints of this problem.

      Input

      The input is given from Standard Input in the following format:
      N K
      P_1 P_2 \dots P_N

      Output

      Print the minimum value of i_K - i_1 among all good index sequences.

      Constraints


      - 1 \leq K \leq N \leq 2 \times 10^5
      - 1 \leq P_i \leq N
      - P_i \neq P_j if i \neq j.
      - All input values are integers.

      Sample Input 1

      4 2
      2 3 1 4

      Sample Output 1

      1

      The good index sequences are (1,2),(1,3),(2,4). For example, (i_1, i_2) = (1,3) is a good index sequence because 1 \leq i_1 < i_2 \leq N and (P_{i_1}, P_{i_2}) = (2,1) is a rearrangement of two consecutive integers 1, 2.
      Among these good index sequences, the smallest value of i_K - i_1 is for (1,2), which is 2-1=1.

      Sample Input 2

      4 1
      2 3 1 4

      Sample Output 2

      0

      i_K - i_1 = i_1 - i_1 = 0 in all good index sequences.

      Sample Input 3

      10 5
      10 1 6 8 7 2 5 9 3 4

      Sample Output 3

      5

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "4 2\n2 3 1 4\n",
              "1\n"
          ],
          [
              "4 1\n2 3 1 4\n",
              "0\n"
          ],
          [
              "10 5\n10 1 6 8 7 2 5 9 3 4\n",
              "5\n"
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
