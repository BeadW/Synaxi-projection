Feature: LiveCodeBench/atcoder/hard — Complement Interval Graph
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      For integers l, r, let [l, r] denote the set of all integers from l through r. That is, [l, r] = \lbrace l, l+1, l+2, \ldots, r-1, r\rbrace.
      You are given N pairs of integers (L_1, R_1), (L_2, R_2), \ldots, (L_N, R_N).
      Based on these pairs, consider an undirected graph G defined as follows:

      - It has N vertices numbered 1, 2, \ldots, N.
      - For all i, j \in [1, N], there is an undirected edge between vertices i and j if and only if the intersection of [L_i, R_i] and [L_j, R_j] is empty.

      In addition, for each i = 1, 2, \ldots, N, define the weight of vertex i to be W_i.
      You are given Q queries about G. Process these queries in the order they are given.
      For each i = 1, 2, \ldots, Q, the i-th query is the following:

      You are given integers s_i and t_i (both between 1 and N, inclusive) such that s_i \neq t_i. Determine whether there exists a path from vertex s_i to vertex t_i in G. If it exists, print the minimum possible weight of such a path.

      Here, the weight of a path from vertex s to vertex t is defined as the sum of the weights of the vertices on that path (including both endpoints s and t).

      Input

      The input is given from Standard Input in the following format:
      N
      W_1 W_2 \cdots W_N
      L_1 R_1
      L_2 R_2
      \vdots
      L_N R_N
      Q
      s_1 t_1
      s_2 t_2
      \vdots
      s_Q t_Q

      Output

      Print Q lines.
      For each i = 1, 2, \ldots, Q, on the i-th line, if there exists a path from vertex s_i to vertex t_i, print the minimum possible weight of such a path, and print -1 otherwise.

      Constraints


      - 2 \leq N \leq 2 \times 10^5
      - 1 \leq Q \leq 2 \times 10^5
      - 1 \leq W_i \leq 10^9
      - 1 \leq L_i \leq R_i \leq 2N
      - 1 \leq s_i, t_i \leq N
      - s_i \neq t_i
      - All input values are integers.

      Sample Input 1

      5
      5 1 4 2 2
      2 4
      1 2
      7 8
      4 5
      2 7
      3
      1 4
      4 3
      5 2

      Sample Output 1

      11
      6
      -1

      G is a graph with four undirected edges: \lbrace 1, 3\rbrace, \lbrace 2, 3\rbrace, \lbrace 2, 4\rbrace, \lbrace 3, 4\rbrace.

      - For the first query, there is a path from vertex 1 to vertex 4 given by 1 \to 3 \to 4. The weight of this path is 

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5\n5 1 4 2 2\n2 4\n1 2\n7 8\n4 5\n2 7\n3\n1 4\n4 3\n5 2",
              "11\n6\n-1"
          ],
          [
              "8\n44 75 49 4 78 79 12 32\n5 13\n10 16\n6 8\n6 15\n12 15\n5 7\n1 15\n1 2\n5\n5 6\n3 2\n7 5\n4 5\n5 4",
              "157\n124\n-1\n114\n114"
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
