Feature: LiveCodeBench/atcoder/hard — Typical Permutation Descriptor
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a sequence of integers (A_1,\dots,A_N) of length N. This sequence satisfies 0\le A_i < i for each i=1,\dots,N.
      Find the number of permutations (P_1,\dots,P_N) of (1,\dots,N) that satisfy the following conditions, modulo 998244353.

      - For each i=1,\dots,N:
      - P_j > P_i for any integer j with A_i < j < i 
      - P_{A_i} < P_i if A_i > 0



      For the sequence (A_1,\dots,A_N) given in the input, it is guaranteed that there exists a permutation satisfying the conditions.

      Input

      The input is given from Standard Input in the following format:
      N
      A_1 A_2 \dots A_N

      Output

      Print the number of permutations satisfying the conditions, modulo 998244353.

      Constraints


      - 1\le N\le 3\times 10^5
      - 0\le A_i \lt i
      - For A_1,\dots,A_N, there exists a permutation satisfying the conditions in the problem statement.
      - All input values are integers.

      Sample Input 1

      4
      0 1 0 3

      Sample Output 1

      3

      There are three such permutations: (2, 3, 1, 4), (2, 4, 1, 3), and (3, 4, 1, 2).

      Sample Input 2

      22
      0 1 2 2 2 2 2 2 1 9 9 9 9 0 14 15 15 15 14 19 19 19

      Sample Output 2

      353820794

      The answer is 353820794, which is 2350309500 modulo 998244353.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "4\n0 1 0 3",
              "3"
          ],
          [
              "22\n0 1 2 2 2 2 2 2 1 9 9 9 9 0 14 15 15 15 14 19 19 19",
              "353820794"
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
