Feature: LiveCodeBench/atcoder/hard — Road Blocked
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      In the nation of AtCoder, there are N cities numbered 1 to N, and M roads numbered 1 to M.
      Road i connects cities A_i and B_i bidirectionally and has a length of C_i.
      You are given Q queries to process in order. The queries are of the following two types.

      - 1 i: Road i becomes closed.
      - 2 x y: Print the shortest distance from city x to city y, using only roads that are not closed. If city y cannot be reached from city x, print -1 instead.

      It is guaranteed that each test case contains at most 300 queries of the first type.

      Input

      The input is given from Standard Input in the following format:
      N M Q
      A_1 B_1 C_1
      \vdots
      A_M B_M C_M
      \mathrm{query}_1
      \vdots
      \mathrm{query}_Q

      Each query is in one of the following two formats:
      1 i

      2 x y

      Output

      Process the queries in order.

      Constraints


      - 2 \leq N \leq 300
      - 0 \leq M \leq \frac{N(N-1)}{2}
      - 1 \leq A_i < B_i \leq N
      - All pairs (A_i, B_i) are distinct.
      - 1 \leq C_i \leq 10^9
      - 1 \leq Q \leq 2 \times 10^5
      - In the queries of the first type, 1 \leq i \leq M.
      - The road given in a query of the first type is not already closed at that time.
      - The number of queries of the first type is at most 300.
      - In the queries of the second type, 1 \leq x < y \leq N.
      - All input values are integers.

      Sample Input 1

      3 3 5
      1 2 5
      1 3 10
      2 3 6
      2 1 3
      1 2
      2 1 3
      1 1
      2 1 3

      Sample Output 1

      10
      11
      -1


      - In the first query, print the shortest distance from city 1 to city 3, which is 10.
      - In the second query, road 2 becomes closed.
      - In the third query, print the shortest distance from city 1 to city 3, which is 11.
      - In the fourth query, road 1 becomes closed.
      - In the fifth query, city 3 cannot be reached from city 1, so print -1.

      Sample Input 2

      4 6 6
      2 3 1
      2 4 1
      3 4 1
      1 2 1
      1 3 1
      1 4 1
      1 4
      1 5
      1 6
      2 1 2
      2 1 3
      2 1 4

      Sample Output 2

      -1
      -1
      -1

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 3 5\n1 2 5\n1 3 10\n2 3 6\n2 1 3\n1 2\n2 1 3\n1 1\n2 1 3\n",
              "10\n11\n-1\n"
          ],
          [
              "4 6 6\n2 3 1\n2 4 1\n3 4 1\n1 2 1\n1 3 1\n1 4 1\n1 4\n1 5\n1 6\n2 1 2\n2 1 3\n2 1 4\n",
              "-1\n-1\n-1\n"
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
