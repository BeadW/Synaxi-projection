Feature: LiveCodeBench/atcoder/hard — Minimize Sum of Distances
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a tree with N vertices. The vertices are numbered 1 to N, and the i-th edge connects vertices A_i and B_i.
      You are also given a sequence of positive integers C = (C_1, C_2, \ldots ,C_N) of length N. Let d(a, b) be the number of edges between vertices a and b, and for x = 1, 2, \ldots, N, let \displaystyle f(x) = \sum_{i=1}^{N} (C_i \times d(x, i)). Find \displaystyle \min_{1 \leq v \leq N} f(v).

      Input

      The input is given from Standard Input in the following format:
      N
      A_1 B_1
      A_2 B_2
      \vdots
      A_{N - 1} B_{N - 1}
      C_1 C_2 \cdots C_N

      Output

      Print the answer in one line.

      Constraints


      - 1 \leq N \leq 10^5
      - 1 \leq A_i, B_i \leq N
      - The given graph is a tree.
      - 1 \leq C_i \leq 10^9

      Sample Input 1

      4
      1 2
      1 3
      2 4
      1 1 1 2

      Sample Output 1

      5

      For example, consider calculating f(1). We have d(1, 1) = 0, d(1, 2) = 1, d(1, 3) = 1, d(1, 4) = 2.
      Thus, f(1) = 0 \times 1 + 1 \times 1 + 1 \times 1 + 2 \times 2 = 6.
      Similarly, f(2) = 5, f(3) = 9, f(4) = 6. Since f(2) is the minimum, print 5.

      Sample Input 2

      2
      2 1
      1 1000000000

      Sample Output 2

      1

      f(2) = 1, which is the minimum.

      Sample Input 3

      7
      7 3
      2 5
      2 4
      3 1
      3 6
      2 1
      2 7 6 9 3 4 6

      Sample Output 3

      56

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "4\n1 2\n1 3\n2 4\n1 1 1 2\n",
              "5\n"
          ],
          [
              "2\n2 1\n1 1000000000\n",
              "1\n"
          ],
          [
              "7\n7 3\n2 5\n2 4\n3 1\n3 6\n2 1\n2 7 6 9 3 4 6\n",
              "56\n"
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
