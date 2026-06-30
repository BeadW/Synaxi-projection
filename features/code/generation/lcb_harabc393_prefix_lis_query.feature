Feature: LiveCodeBench/atcoder/hard — Prefix LIS Query
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a sequence A = (A_1, A_2, \dots, A_N) of length N.
      Answer Q queries. The i-th query (1 \leq i \leq Q) is as follows:

      - You are given integers R_i and X_i. Consider a subsequence (not necessarily contiguous) of (A_1, A_2, \dots, A_{R_i}) that is strictly increasing and consists only of elements at most X_i. Find the maximum possible length of such a subsequence.
      It is guaranteed that X_i \geq \min\lbrace A_1, A_2,\dots,A_{R_i} \rbrace.

      Input

      The input is given from Standard Input in the following format:
      N Q
      A_1 A_2 \dots A_N
      R_1 X_1
      R_2 X_2
      \vdots
      R_Q X_Q

      Output

      Print Q lines. The i-th line should contain the answer to the i-th query.

      Constraints


      - 1 \leq N,Q \leq 2 \times 10^5
      - 1 \leq A_i \leq 10^9
      - 1 \leq R_i \leq N
      - \min\lbrace A_1, A_2,\dots,A_{R_i} \rbrace\leq X_i\leq 10^9
      - All input values are integers.

      Sample Input 1

      5 3
      2 4 1 3 3
      2 5
      5 2
      5 3

      Sample Output 1

      2
      1
      2


      - 1st query: For the sequence (2,4), the longest strictly increasing subsequence with all elements at most 5 has length 2. Specifically, (2,4) qualifies.
      - 2nd query: For the sequence (2,4,1,3,3), the longest strictly increasing subsequence with all elements at most 2 has length 1. Specifically, (2) and (1) qualify.
      - 3rd query: For the sequence (2,4,1,3,3), the longest strictly increasing subsequence with all elements at most 3 has length 2. Specifically, (2,3) and (1,3) qualify.

      Sample Input 2

      10 8
      2 5 6 5 2 1 7 9 7 2
      7 8
      5 2
      2 3
      2 6
      7 3
      8 9
      9 6
      8 7

      Sample Output 2

      4
      1
      1
      2
      1
      5
      3
      4

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5 3\n2 4 1 3 3\n2 5\n5 2\n5 3",
              "2\n1\n2"
          ],
          [
              "10 8\n2 5 6 5 2 1 7 9 7 2\n7 8\n5 2\n2 3\n2 6\n7 3\n8 9\n9 6\n8 7",
              "4\n1\n1\n2\n1\n5\n3\n4"
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
