Feature: LiveCodeBench/atcoder/hard — Good Graph
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an undirected graph G with N vertices and M edges.
      For i = 1, 2, \ldots, M, the i-th edge is an undirected edge connecting vertices u_i and v_i.
      A graph with N vertices is called good if the following condition holds for all i = 1, 2, \ldots, K:

      - there is no path connecting vertices x_i and y_i in G.

      The given graph G is good.
      You are given Q independent questions. Answer all of them.
      For i = 1, 2, \ldots, Q, the i-th question is as follows.

      - Is the graph G^{(i)} obtained by adding an undirected edge connecting vertices p_i and q_i to the given graph G good?

      Input

      The input is given from Standard Input in the following format:
      N M
      u_1 v_1
      u_2 v_2
      \vdots
      u_M v_M
      K
      x_1 y_1
      x_2 y_2
      \vdots
      x_K y_K
      Q
      p_1 q_1
      p_2 q_2
      \vdots
      p_Q q_Q

      Output

      Print Q lines.
      For i = 1, 2, \ldots, Q, the i-th line should contain the answer to the i-th question: Yes if the graph G^{(i)} is good, and No otherwise.

      Constraints


      - 2 \leq N \leq 2 \times 10^5
      - 0 \leq M \leq 2 \times10^5
      - 1 \leq u_i, v_i \leq N
      - 1 \leq K \leq 2 \times 10^5
      - 1 \leq x_i, y_i \leq N
      - x_i \neq y_i
      - i \neq j \implies \lbrace x_i, y_i \rbrace \neq \lbrace x_j, y_j \rbrace
      - For all i = 1, 2, \ldots, K, there is no path connecting vertices x_i and y_i.
      - 1 \leq Q \leq 2 \times 10^5
      - 1 \leq p_i, q_i \leq N
      - p_i \neq q_i
      - All input values are integers.

      Sample Input 1

      6 6
      1 2
      2 3
      2 3
      3 1
      5 4
      5 5
      3
      1 5
      2 6
      4 3
      4
      2 5
      2 6
      5 6
      5 4

      Sample Output 1

      No
      No
      Yes
      Yes


      - For the first question, the graph G^{(1)} is not good because it has a path 1 \rightarrow 2 \rightarrow 5 connecting vertices x_1 = 1 and y_1 = 5. Therefore, print No.
      - For the second question, the graph G^{(2)} is not good because it has a path 2 \rightarrow 6 connecting vertices x_2 = 2 and y_2 = 6. Therefore, print No.
      - For the third question, the graph G^{(3)} is good. Therefore, print Yes.
      - For the fourth question, the graph G^{(4)} is good. Therefore, print Yes.

      As seen in this sample inp

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "6 6\n1 2\n2 3\n2 3\n3 1\n5 4\n5 5\n3\n1 5\n2 6\n4 3\n4\n2 5\n2 6\n5 6\n5 4\n",
              "No\nNo\nYes\nYes\n"
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
