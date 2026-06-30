Feature: LiveCodeBench/atcoder/hard — Rearrange Query
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given sequences of positive integers of length N: A=(A_1,A_2,\ldots,A_N) and B=(B_1,B_2,\ldots,B_N).
      You are given Q queries to process in order. The i-th query is explained below.

      - You are given positive integers l_i,r_i,L_i,R_i. Print Yes if it is possible to rearrange the subsequence (A_{l_i},A_{l_i+1},\ldots,A_{r_i}) to match the subsequence (B_{L_i},B_{L_i+1},\ldots,B_{R_i}), and No otherwise.

      Input

      The input is given from Standard Input in the following format:
      N Q
      A_1 A_2 \ldots A_N
      B_1 B_2 \ldots B_N
      l_1 r_1 L_1 R_1
      l_2 r_2 L_2 R_2
      \vdots
      l_Q r_Q L_Q R_Q

      Output

      Print Q lines. The i-th line should contain the answer to the i-th query.

      Constraints


      -  1\leq N,Q\leq 2\times 10^5
      -  1\leq A_i,B_i\leq N
      -  1\leq l_i \leq r_i\leq N
      -  1\leq L_i \leq R_i\leq N
      - All input values are integers.

      Sample Input 1

      5 4
      1 2 3 2 4
      2 3 1 4 2
      1 3 1 3
      1 2 3 5
      1 4 2 5
      1 5 1 5

      Sample Output 1

      Yes
      No
      No
      Yes


      - For the 1st query, it is possible to rearrange (1,2,3) to match (2,3,1). Hence, we print Yes.
      - For the 2nd query, it is impossible to rearrange (1,2) in any way to match (1,4,2). Hence, we print No.
      - For the 3rd query, it is impossible to rearrange (1,2,3,2) in any way to match (3,1,4,2). Hence, we print No.
      - For the 4th query, it is possible to rearrange (1,2,3,2,4) to match (2,3,1,4,2). Hence, we print Yes.

      Sample Input 2

      4 4
      4 4 4 4
      4 4 4 4
      1 2 2 3
      3 3 1 1
      1 3 1 4
      1 4 2 3

      Sample Output 2

      Yes
      Yes
      No
      No

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5 4\n1 2 3 2 4\n2 3 1 4 2\n1 3 1 3\n1 2 3 5\n1 4 2 5\n1 5 1 5\n",
              "Yes\nNo\nNo\nYes\n"
          ],
          [
              "4 4\n4 4 4 4\n4 4 4 4\n1 2 2 3\n3 3 1 1\n1 3 1 4\n1 4 2 3\n",
              "Yes\nYes\nNo\nNo\n"
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
