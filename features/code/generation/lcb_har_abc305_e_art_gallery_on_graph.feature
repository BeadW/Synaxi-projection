Feature: LiveCodeBench/atcoder/hard — Art Gallery on Graph
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a simple undirected graph with N vertices and M edges, where vertices are numbered from 1 to N, and edges are numbered from 1 to M. Edge i connects vertex a_i and vertex b_i.
      K security guards numbered from 1 to K are on some vertices. Guard i is on vertex p_i and has a stamina of h_i. All p_i are distinct.
      A vertex v is said to be guarded when the following condition is satisfied:

      - there is at least one guard i such that the distance between vertex v and vertex p_i is at most h_i.

      Here, the distance between vertex u and vertex v is the minimum number of edges in the path connecting vertices u and v.
      List all guarded vertices in ascending order.

      Input

      The input is given from Standard Input in the following format:
      N M K
      a_1 b_1
      a_2 b_2
      \vdots
      a_M b_M
      p_1 h_1
      p_2 h_2
      \vdots
      p_K h_K

      Output

      Print the answer in the following format. Here,

      - G is the number of guarded vertices,
      - and v_1, v_2, \dots, v_G are the vertex numbers of the guarded vertices in ascending order.

      G
      v_1 v_2 \dots v_G

      Constraints


      - 1 \leq N \leq 2 \times 10^5
      - 0 \leq M \leq \min \left(\frac{N(N-1)}{2}, 2 \times 10^5 \right)
      - 1 \leq K \leq N
      - 1 \leq a_i, b_i \leq N
      - The given graph is simple.
      - 1 \leq p_i \leq N
      - All p_i are distinct.
      - 1 \leq h_i \leq N
      - All input values are integers.

      Sample Input 1

      5 5 2
      1 2
      2 3
      2 4
      3 5
      1 5
      1 1
      5 2

      Sample Output 1

      4
      1 2 3 5

      The guarded vertices are 1, 2, 3, 5.
      These vertices are guarded because of the following reasons.

      - The distance between vertex 1 and vertex p_1 = 1 is 0, which is not greater than h_1 = 1. Thus, vertex 1 is guarded.
      - The distance between vertex 2 and vertex p_1 = 1 is 1, which is not greater than h_1 = 1. Thus, vertex 2 is guarded.
      - The distance between vertex 3 and vertex p_2 = 5 is 1, which is not greater than h_2 = 2. Thus, vertex 3 is guarded.
      - The distance between vertex 5 and vertex p_1 = 1 is 1, which is not greater than h_1 = 1. Thus, vertex 5 is guarded.

      Sample Input 2

      3 0 1
      2 3

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5 5 2\n1 2\n2 3\n2 4\n3 5\n1 5\n1 1\n5 2\n",
              "4\n1 2 3 5\n"
          ],
          [
              "3 0 1\n2 3\n",
              "1\n2\n"
          ],
          [
              "10 10 2\n2 1\n5 1\n6 1\n2 4\n2 5\n2 10\n8 5\n8 6\n9 6\n7 9\n3 4\n8 2\n",
              "7\n1 2 3 5 6 8 9\n"
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
