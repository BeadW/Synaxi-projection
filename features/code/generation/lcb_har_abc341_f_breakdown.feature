Feature: LiveCodeBench/atcoder/hard — Breakdown
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a simple undirected graph consisting of N vertices and M edges.
      For i = 1, 2, \ldots, M, the i-th edge connects vertices u_i and v_i.
      Also, for i = 1, 2, \ldots, N, vertex i is assigned a positive integer W_i, and there are A_i pieces placed on it.
      As long as there are pieces on the graph, repeat the following operation:

      - First, choose and remove one piece from the graph, and let x be the vertex on which the piece was placed.
      - Choose a (possibly empty) set S of vertices adjacent to x such that \sum_{y \in S} W_y \lt W_x, and place one piece on each vertex in S.

      Print the maximum number of times the operation can be performed.
      It can be proved that, regardless of how the operation is performed, there will be no pieces on the graph after a finite number of iterations.

      Input

      The input is given from Standard Input in the following format:
      N M
      u_1 v_1
      u_2 v_2
      \vdots
      u_M v_M
      W_1 W_2 \ldots W_N
      A_1 A_2 \ldots A_N

      Output

      Print the answer.

      Constraints


      - All input values are integers.
      - 2 \leq N \leq 5000
      - 1 \leq M \leq \min \lbrace N(N-1)/2, 5000 \rbrace
      - 1 \leq u_i, v_i \leq N
      - u_i \neq v_i
      - i \neq j \implies \lbrace u_i, v_i \rbrace \neq \lbrace u_j, v_j \rbrace
      - 1 \leq W_i \leq 5000
      - 0 \leq A_i \leq 10^9

      Sample Input 1

      6 6
      1 2
      2 3
      3 1
      3 4
      1 5
      5 6
      9 2 3 1 4 4
      1 0 0 0 0 1

      Sample Output 1

      5

      In the following explanation, let A = (A_1, A_2, \ldots, A_N) represent the numbers of pieces on the vertices.
      Initially, A = (1, 0, 0, 0, 0, 1).
      Consider performing the operation as follows:

      - Remove one piece from vertex 1 and place one piece each on vertices 2 and 3. Now, A = (0, 1, 1, 0, 0, 1).
      - Remove one piece from vertex 2. Now, A = (0, 0, 1, 0, 0, 1).
      - Remove one piece from vertex 6. Now, A = (0, 0, 1, 0, 0, 0).
      - Remove one piece from vertex 3 and place one piece on vertex 2. Now, A = (0, 1, 0, 0, 0, 0).
      - Remove one piece from vertex 2. Now, A = (0, 0, 0, 0, 0, 0).

      In this procedure, the operation is performed five times, which is the maxi

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "6 6\n1 2\n2 3\n3 1\n3 4\n1 5\n5 6\n9 2 3 1 4 4\n1 0 0 0 0 1\n",
              "5\n"
          ],
          [
              "2 1\n1 2\n1 2\n0 0\n",
              "0\n"
          ],
          [
              "10 20\n4 8\n1 10\n1 7\n5 9\n9 10\n8 10\n7 5\n1 4\n7 3\n8 7\n2 8\n5 8\n4 2\n5 1\n7 2\n8 3\n3 4\n8 9\n7 10\n2 3\n25 5 1 1 16 5 98 3 21 1\n35 39 32 11 35 37 14 29 36 1\n",
              "1380\n"
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
              assert r.stdout.strip() == str(expected).strip(), (
                  f"Case {i}: expected {expected!r}, got {r.stdout!r}"
              )

      """

  Scenario: Agent solves the LiveCodeBench problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py to read from stdin and write the correct answer to stdout so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
