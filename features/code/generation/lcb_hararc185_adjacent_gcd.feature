Feature: LiveCodeBench/atcoder/hard — Adjacent GCD
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Define the score of a sequence of positive integers B = (B_1, B_2, \dots, B_k) as \displaystyle \sum_{i=1}^{k-1} \gcd(B_i, B_{i+1}).
      Given a sequence of positive integers A = (A_1, A_2, \dots, A_N), solve the following problem for m = 1, 2, \dots, N.

      - There are 2^m - 1 non-empty subsequences of the sequence (A_1, A_2, \dots, A_m). Find the sum of the scores of all those subsequences, modulo 998244353. Two subsequences are distinguished if they are taken from different positions in the sequence, even if they coincide as sequences.

      Input

      The input is given from Standard Input in the following format:
      N
      A_1 A_2 \dots A_N

      Output

      Print N lines. The i-th line should contain the answer for m = i.

      Constraints


      - 1 \leq N \leq 5 \times 10^5
      - 1 \leq A_i \leq 10^5
      - All input values are integers.

      Sample Input 1

      3
      9 6 4

      Sample Output 1

      0
      3
      11

      Consider the case m = 3. Here are the non-empty subsequences of (A_1, A_2, A_3) = (9, 6, 4) and their scores.

      - (9): Score is 0.
      - (6): Score is 0.
      - (4): Score is 0.
      - (9, 6): Score is \gcd(9, 6) = 3.
      - (9, 4): Score is \gcd(9, 4) = 1.
      - (6, 4): Score is \gcd(6, 4) = 2.
      - (9, 6, 4): Score is \gcd(9, 6) + \gcd(6, 4) = 3 + 2 = 5.

      Therefore, the answer for m = 3 is 0 + 0 + 0 + 3 + 1 + 2 + 5 = 11.

      Sample Input 2

      5
      3 8 12 6 9

      Sample Output 2

      0
      1
      13
      57
      155

      Sample Input 3

      10
      47718 21994 74148 76721 98917 73766 29598 59035 69293 29127

      Sample Output 3

      0
      2
      14
      35
      97
      372
      866
      1859
      4273
      43287

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n9 6 4",
              "0\n3\n11"
          ],
          [
              "5\n3 8 12 6 9",
              "0\n1\n13\n57\n155"
          ],
          [
              "10\n47718 21994 74148 76721 98917 73766 29598 59035 69293 29127",
              "0\n2\n14\n35\n97\n372\n866\n1859\n4273\n43287"
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
