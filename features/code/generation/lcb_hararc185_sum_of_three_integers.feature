Feature: LiveCodeBench/atcoder/hard — Sum of Three Integers
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an integer sequence A = (A_1, A_2, \dots, A_N) and an integer X.
      Print one triple of integers (i, j, k) satisfying all of the following conditions. If no such triple exists, report that fact.

      - 1 \leq i \lt j \lt k \leq N
      - A_i + A_j + A_k = X

      Input

      The input is given from Standard Input in the following format:
      N X
      A_1 A_2 \dots A_N

      Output

      If there exists an integer triple (i, j, k) satisfying the conditions, print one in the following format. If there are multiple solutions, you may print any of them.
      i j k

      If no such triple exists, print -1.

      Constraints


      - 3 \leq N \leq 10^6
      - 1 \leq X \leq 10^6
      - 1 \leq A_i \leq X
      - All input values are integers.

      Sample Input 1

      5 16
      1 8 5 10 13

      Sample Output 1

      1 3 4

      The triple (i, j, k) = (1, 3, 4) satisfies 1 \leq i \lt j \lt k \leq N and A_i + A_j + A_k = 1 + 5 + 10 = 16 = X.

      Sample Input 2

      5 20
      1 8 5 10 13

      Sample Output 2

      -1

      Sample Input 3

      10 100000
      73766 47718 74148 49218 76721 31902 21994 18880 29598 98917

      Sample Output 3

      4 6 8

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5 16\n1 8 5 10 13",
              "1 3 4"
          ],
          [
              "5 20\n1 8 5 10 13",
              "-1"
          ],
          [
              "10 100000\n73766 47718 74148 49218 76721 31902 21994 18880 29598 98917",
              "4 6 8"
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
