Feature: LiveCodeBench/atcoder/hard — Divide Interval
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      For non-negative integers l and r (l < r), let S(l, r) denote the sequence (l, l+1, \ldots, r-2, r-1) formed by arranging integers from l through r-1 in order. Furthermore, a sequence is called a good sequence if and only if it can be represented as S(2^i j, 2^i (j+1)) using non-negative integers i and j.
      You are given non-negative integers L and R (L < R). Divide the sequence S(L, R) into the fewest number of good sequences, and print that number of sequences and the division. More formally, find the minimum positive integer M for which there is a sequence of pairs of non-negative integers (l_1, r_1), (l_2, r_2), \ldots, (l_M, r_M) that satisfies the following, and print such (l_1, r_1), (l_2, r_2), \ldots, (l_M, r_M).

      - L = l_1 < r_1 = l_2 < r_2 = \cdots = l_M < r_M = R
      - S(l_1, r_1), S(l_2, r_2), \ldots, S(l_M, r_M) are good sequences.

      It can be shown that there is only one division that minimizes M.

      Input

      The input is given from Standard Input in the following format:
      L R

      Output

      Print the answer in the following format:
      M
      l_1 r_1
      \vdots
      l_M r_M

      Note that the pairs (l_1, r_1), \dots, (l_M, r_M) should be printed in ascending order.

      Constraints


      - 0 \leq L < R \leq 2^{60}
      - All input values are integers.

      Sample Input 1

      3 19

      Sample Output 1

      5
      3 4
      4 8
      8 16
      16 18
      18 19

      S(3,19)=(3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18) can be divided into the following five good sequences, which is the minimum possible number:

      - S(3,4)=S(2^0\cdot 3,2^0\cdot4)=(3)
      - S(4,8)=S(2^2\cdot 1,2^2\cdot 2)=(4,5,6,7)
      - S(8,16)=S(2^3\cdot 1,2^3\cdot 2)=(8,9,10,11,12,13,14,15)
      - S(16,18)=S(2^1\cdot 8,2^1\cdot 9)=(16,17)
      - S(18,19)=S(2^0\cdot 18,2^0\cdot 19)=(18)

      Sample Input 2

      0 1024

      Sample Output 2

      1
      0 1024

      Sample Input 3

      3940649673945088 11549545024454656

      Sample Output 3

      8
      3940649673945088 3940649673949184
      3940649673949184 4503599627370496
      4503599627370496 9007199254740992
      9007199254740992 11258999068426240
      11258999068426240 11540474045136896
      11540474045136896 11549270138

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 19\n",
              "5\n3 4\n4 8\n8 16\n16 18\n18 19\n"
          ],
          [
              "0 1024\n",
              "1\n0 1024\n"
          ],
          [
              "3940649673945088 11549545024454656\n",
              "8\n3940649673945088 3940649673949184\n3940649673949184 4503599627370496\n4503599627370496 9007199254740992\n9007199254740992 11258999068426240\n11258999068426240 11540474045136896\n11540474045136896 11549270138159104\n11549270138159104 11549545016066048\n11549545016066048 11549545024454656\n"
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
