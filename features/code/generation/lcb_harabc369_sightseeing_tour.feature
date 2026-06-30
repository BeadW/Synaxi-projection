Feature: LiveCodeBench/atcoder/hard — Sightseeing Tour
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There are N islands and M bidirectional bridges connecting two islands. The islands and bridges are numbered 1, 2, \ldots, N and 1, 2, \ldots, M, respectively.
      Bridge i connects islands U_i and V_i, and the time it takes to cross it in either direction is T_i.
      No bridge connects an island to itself, but it is possible for two islands to be directly connected by more than one bridge.
      One can travel between any two islands using some bridges.
      You are given Q queries, so answer each of them. The i-th query is as follows:

      You are given K_i distinct bridges: bridges B_{i,1}, B_{i,2}, \ldots, B_{i,K_i}.
      Find the minimum time required to travel from island 1 to island N using each of these bridges at least once.
      Only consider the time spent crossing bridges.
      You can cross the given bridges in any order and in any direction.

      Input

      The input is given from Standard Input in the following format:
      N M
      U_1 V_1 T_1
      U_2 V_2 T_2
      \vdots
      U_M V_M T_M
      Q
      K_1
      B_{1,1} B_{1,2} \cdots B_{1,{K_1}}
      K_2
      B_{2,1} B_{2,2} \cdots B_{2,{K_2}}
      \vdots
      K_Q
      B_{Q,1} B_{Q,2} \cdots B_{Q,{K_Q}}

      Output

      Print Q lines. The i-th line (1 \leq i \leq Q) should contain the answer to the i-th query as an integer.

      Constraints


      - 2 \leq N \leq 400
      - N-1 \leq M \leq 2 \times 10^5
      - 1 \leq U_i < V_i \leq N
      - 1 \leq T_i \leq 10^9
      - 1 \leq Q \leq 3000
      - 1 \leq K_i \leq 5
      - 1 \leq B_{i,1} < B_{i,2} < \cdots < B_{i,K_i} \leq M
      - All input values are integers.
      - It is possible to travel between any two islands using some bridges.

      Sample Input 1

      3 5
      1 2 10
      1 3 20
      1 3 30
      2 3 15
      2 3 25
      2
      1
      1
      2
      3 5

      Sample Output 1

      25
      70

      For the first query, we need to find the minimum time to travel from island 1 to island 3 while using bridge 1.
      The minimum time is achieved by using bridge 1 to move from island 1 to island 2, then using bridge 4 to move from island 2 to island 3. The time taken is 10 + 15 = 25.
      Hence, print 25 on the first line.
      For the second query, we need to find the minimum tim

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 5\n1 2 10\n1 3 20\n1 3 30\n2 3 15\n2 3 25\n2\n1\n1\n2\n3 5\n",
              "25\n70\n"
          ],
          [
              "6 6\n1 5 1\n2 5 1\n2 4 1\n3 4 1\n3 6 1\n1 6 1\n2\n5\n1 2 3 4 5\n1\n5\n",
              "5\n3\n"
          ],
          [
              "5 5\n1 2 1000000000\n2 3 1000000000\n3 4 1000000000\n4 5 1000000000\n1 5 1000000000\n1\n1\n3\n",
              "4000000000\n"
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
