Feature: LiveCodeBench/atcoder/hard — Not Argmax
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Find the number, modulo 998244353, of permutations P=(P_1,P_2,\cdots,P_N) of (1,2,\cdots,N) that satisfy all of the following M conditions.

      - The i-th condition: The maximum among P_{L_i},P_{L_i+1},\cdots,P_{R_i} is not P_{X_i}.
      Here, L_i, R_i, and X_i are integers given in the input.

      Input

      The input is given from Standard Input in the following format:
      N M
      L_1 R_1 X_1
      L_2 R_2 X_2
      \vdots
      L_M R_M X_M

      Output

      Print the answer.

      Constraints


      - 1 \leq N \leq 500
      - 1 \leq M \leq 10^5
      - 1 \leq L_i \leq X_i \leq R_i \leq N
      - All input values are integers.

      Sample Input 1

      3 2
      1 3 2
      1 2 1

      Sample Output 1

      1

      Only one permutation, P=(1,2,3), satisfies the conditions.

      Sample Input 2

      5 1
      1 1 1

      Sample Output 2

      0

      Sample Input 3

      10 5
      3 8 4
      3 10 4
      1 7 2
      1 8 3
      3 8 7

      Sample Output 3

      1598400

      Sample Input 4

      15 17
      2 11 9
      2 15 13
      1 14 2
      5 11 5
      3 15 11
      1 6 2
      4 15 12
      3 11 6
      9 13 10
      2 14 6
      10 15 11
      1 8 6
      6 14 8
      2 10 2
      6 12 6
      3 14 12
      2 6 2

      Sample Output 4

      921467228

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 2\n1 3 2\n1 2 1\n",
              "1\n"
          ],
          [
              "5 1\n1 1 1\n",
              "0\n"
          ],
          [
              "10 5\n3 8 4\n3 10 4\n1 7 2\n1 8 3\n3 8 7\n",
              "1598400\n"
          ],
          [
              "15 17\n2 11 9\n2 15 13\n1 14 2\n5 11 5\n3 15 11\n1 6 2\n4 15 12\n3 11 6\n9 13 10\n2 14 6\n10 15 11\n1 8 6\n6 14 8\n2 10 2\n6 12 6\n3 14 12\n2 6 2\n",
              "921467228\n"
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
