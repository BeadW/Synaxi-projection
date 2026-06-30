Feature: LiveCodeBench/atcoder/hard — Keep Distance
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given integers N and M.
      Print all integer sequences (A_1, A_2, \ldots, A_N) of length N that satisfy all of the following conditions, in lexicographical order.

      - 1 \leq A_i
      - A_{i - 1} + 10 \leq A_i for each integer i from 2 through N
      - A_N \leq M

      What is lexicographical order?
      A sequence S = (S_1, S_2, \ldots, S_N) of length N is smaller in lexicographical order than a sequence T = (T_1, T_2, \ldots, T_N) of length N if and only if there exists an integer 1 \leq i \leq N such that both of the following hold:

      -  (S_1, S_2, \ldots, S_{i-1}) = (T_1, T_2, \ldots, T_{i-1})
      -  S_i is less than T_i (as a number).

      Input

      The input is given from Standard Input in the following format:
      N M

      Output

      Let X be the number of integer sequences that satisfy the conditions, and print X + 1 lines.
      The first line should contain the value of X.
      The (i + 1)-th line (1 \leq i \leq X) should contain the i-th smallest integer sequence in lexicographical order, with elements separated by spaces.

      Constraints


      - 2 \leq N \leq 12
      - 10N - 9 \leq M \leq 10N
      - All input values are integers.

      Sample Input 1

      3 23

      Sample Output 1

      10
      1 11 21
      1 11 22
      1 11 23
      1 12 22
      1 12 23
      1 13 23
      2 12 22
      2 12 23
      2 13 23
      3 13 23

      (1, 11, 21), (1, 11, 22), (1, 11, 23), (1, 12, 22), (1, 12, 23), (1, 13, 23), (2, 12, 22), (2, 12, 23), (2, 13, 23), (3, 13, 23) are the 10 sequences that satisfy the conditions.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 23",
              "10\n1 11 21\n1 11 22\n1 11 23\n1 12 22\n1 12 23\n1 13 23\n2 12 22\n2 12 23\n2 13 23\n3 13 23"
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
