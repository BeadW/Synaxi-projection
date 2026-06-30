Feature: LiveCodeBench/atcoder/hard — Another Shuffle Window
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a permutation P of (1,2,\dots,N) and an integer K.  
      Find the expected value, modulo 998244353, of the inversion number of P after performing the following operation:

      - First, choose an integer i uniformly at random between 1 and N - K + 1, inclusive.
      - Then, shuffle P_i, P_{i+1}, \dots, P_{i+K-1} uniformly at random.


      What is the inversion number?
      The inversion number of a sequence (A_1, A_2, \dots, A_N) is the number of integer pairs (i, j) satisfying 1 \le i < j \le N and A_i > A_j.


      What does "expected value modulo 998244353" mean?
      It can be proved that the sought expected value is always rational. Under the constraints of this problem, when this value is represented as an irreducible fraction \frac{P}{Q}, it can also be proved that Q \not\equiv 0 \pmod{998244353}. Thus, there is a unique integer R satisfying R \times Q \equiv P \pmod{998244353}, \ 0 \le R < 998244353. Report this integer R.

      Input

      The input is given from Standard Input in the following format:
      N K
      P_1 P_2 \dots P_N

      Output

      Print the answer in one line.

      Constraints


      - All input values are integers.
      - 1 \le K \le N \le 2 \times 10^5
      - P is a permutation of (1,2,\dots,N).

      Sample Input 1

      4 2
      1 4 2 3

      Sample Output 1

      166374061

      The operation changes the permutation P into the following:

      - (1,4,2,3) ... probability 1/2
      - (4,1,2,3) ... probability 1/6
      - (1,2,4,3) ... probability 1/6
      - (1,4,3,2) ... probability 1/6

      The expected value of the inversion number is \displaystyle 2 \times \frac{1}{2} + 3 \times \frac{1}{6} + 1 \times \frac{1}{6} + 3 \times \frac{1}{6} = \frac{13}{6}.
      \displaystyle \frac{13}{6} modulo 998244353 is 166374061, so print this number.

      Sample Input 2

      1 1
      1

      Sample Output 2

      0

      Sample Input 3

      10 6
      7 4 10 5 6 1 8 2 3 9

      Sample Output 3

      499122200

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "4 2\n1 4 2 3",
              "166374061"
          ],
          [
              "1 1\n1",
              "0"
          ],
          [
              "10 6\n7 4 10 5 6 1 8 2 3 9",
              "499122200"
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
