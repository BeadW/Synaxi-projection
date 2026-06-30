Feature: LiveCodeBench/atcoder/hard — Sum of CC
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      For a sequence A = (A_1, \ldots, A_N) of length N, define f(A) as follows.

      - Prepare a graph with N vertices labeled 1 to N and zero edges. For every integer pair (i, j) satisfying 1 \leq i < j \leq N, if A_i \leq A_j, draw a bidirectional edge connecting vertices i and j. Define f(A) as the number of connected components in the resulting graph.

      You are given a sequence B = (B_1, \ldots, B_N) of length N. Each element of B is -1 or an integer between 1 and M, inclusive.
      By replacing every occurrence of -1 in B with an integer between 1 and M, one can obtain M^q sequences B', where q is the number of -1 in B.
      Find the sum, modulo 998244353, of f(B') over all possible B'.

      Input

      The input is given from Standard Input in the following format:
      N M
      B_1 \ldots B_N

      Output

      Print the answer.

      Constraints


      - All input numbers are integers.
      - 2 \leq N \leq 2000
      - 1 \leq M \leq 2000
      - Each B_i is -1 or an integer between 1 and M, inclusive.

      Sample Input 1

      3 3
      2 -1 1

      Sample Output 1

      6

      There are three possible sequences B': (2,1,1), (2,2,1), and (2,3,1).
      When B' = (2,1,1), an edge is drawn only between vertices 2 and 3, so the number of connected components is 2. Thus, f(B') = 2.
      Similarly, f(B') = 2 for B' = (2,2,1) and f(B') = 2 for B' = (2,3,1), so the answer is 2 + 2 + 2 = 6.

      Sample Input 2

      10 8
      -1 7 -1 -1 -1 2 -1 1 -1 2

      Sample Output 2

      329785

      Sample Input 3

      11 12
      -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1

      Sample Output 3

      529513150

      Remember to find the sum modulo 998244353.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 3\n2 -1 1",
              "6"
          ],
          [
              "10 8\n-1 7 -1 -1 -1 2 -1 1 -1 2",
              "329785"
          ],
          [
              "11 12\n-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1",
              "529513150"
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
