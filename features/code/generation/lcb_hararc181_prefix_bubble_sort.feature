Feature: LiveCodeBench/atcoder/hard — Prefix Bubble Sort
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a permutation P=(P_1,P_2,\dots,P_N) of (1,2,\dots,N).
      Consider the following operations k\ (k=2,3,\dots,N) on this permutation.

      - Operation k: For i=1,2,\dots,k-1 in this order, if P_i > P_{i+1}, swap the values of the i-th and (i+1)-th elements of P.

      You are also given a non-decreasing sequence A=(A_1,A_2,\dots,A_M)\ (2 \leq A_i \leq N) of length M.
      For each i=1,2,\dots,M, find the inversion number of P after applying the operations A_1, A_2, \dots, A_i in this order.

       What is the inversion number of a sequence?

      The inversion number of a sequence x=(x_1,x_2,\dots,x_n) of length n is the number of pairs of integers (i,j)\ (1\leq i < j \leq n) such that x_i > x_j.

      Input

      The input is given from Standard Input in the following format:
      N
      P_1 P_2 \dots P_N
      M
      A_1 A_2 \dots A_M

      Output

      Print M lines. The k-th line should contain the answer to the problem for i=k.

      Constraints


      - 2 \leq N \leq 2 \times 10^5
      - 1 \leq M \leq 2 \times 10^5
      - 2 \leq A_i \leq N
      - P is a permutation of (1,2,\dots,N).
      - A_i \leq A_{i+1} for i=1,2,\dots,M-1.
      - All input values are integers.

      Sample Input 1

      6
      3 2 4 1 6 5
      2
      4 6

      Sample Output 1

      3
      1

      First, operation 4 is performed. During this, P changes as follows: (3,2,4,1,6,5) \rightarrow (2,3,4,1,6,5) \rightarrow (2,3,4,1,6,5) \rightarrow (2,3,1,4,6,5). The inversion number of P afterward is 3.
      Next, operation 6 is performed, where P eventually becomes (2,1,3,4,5,6), whose inversion number is 1.

      Sample Input 2

      20
      12 14 16 8 7 15 19 6 18 5 13 9 10 17 4 1 11 20 2 3
      15
      3 4 6 8 8 9 10 12 13 15 18 18 19 19 20

      Sample Output 2

      117
      116
      113
      110
      108
      105
      103
      99
      94
      87
      79
      72
      65
      58
      51

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "6\n3 2 4 1 6 5\n2\n4 6\n",
              "3\n1\n"
          ],
          [
              "20\n12 14 16 8 7 15 19 6 18 5 13 9 10 17 4 1 11 20 2 3\n15\n3 4 6 8 8 9 10 12 13 15 18 18 19 19 20\n",
              "117\n116\n113\n110\n108\n105\n103\n99\n94\n87\n79\n72\n65\n58\n51\n"
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
