Feature: LiveCodeBench/atcoder/hard — Tree and Hamilton Path 2
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      In the nation of AtCoder, there are N cities numbered 1 to N and N-1 roads numbered 1 to N-1.
      Road i connects cities A_i and B_i bidirectionally, and its length is C_i. Any pair of cities can be reached from each other by traveling through some roads.
      Find the minimum travel distance required to start from a city and visit all cities at least once using the roads.

      Input

      The input is given from Standard Input in the following format:
      N
      A_1 B_1 C_1
      \vdots
      A_{N-1} B_{N-1} C_{N-1}

      Output

      Print the answer.

      Constraints


      - 2 \leq N \leq 2\times 10^5
      - 1 \leq A_i, B_i \leq N
      - 1 \leq C_i \leq 10^9
      - All input values are integers.
      - Any pair of cities can be reached from each other by traveling through some roads.

      Sample Input 1

      4
      1 2 2
      1 3 3
      1 4 4

      Sample Output 1

      11

      If you travel as 4 \to 1 \to 2 \to 1 \to 3, the total travel distance is 11, which is the minimum.
      Note that you do not need to return to the starting city.

      Sample Input 2

      10
      10 9 1000000000
      9 8 1000000000
      8 7 1000000000
      7 6 1000000000
      6 5 1000000000
      5 4 1000000000
      4 3 1000000000
      3 2 1000000000
      2 1 1000000000

      Sample Output 2

      9000000000

      Beware overflow.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "4\n1 2 2\n1 3 3\n1 4 4\n",
              "11\n"
          ],
          [
              "10\n10 9 1000000000\n9 8 1000000000\n8 7 1000000000\n7 6 1000000000\n6 5 1000000000\n5 4 1000000000\n4 3 1000000000\n3 2 1000000000\n2 1 1000000000\n",
              "9000000000\n"
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
