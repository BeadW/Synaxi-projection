Feature: LiveCodeBench/atcoder/hard — Path Decomposition of a Tree
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a tree with NK vertices. The vertices are numbered 1,2,\dots,NK, and the i-th edge (i=1,2,\dots,NK-1) connects vertices u_i and v_i bidirectionally.
      Determine whether this tree can be decomposed into N paths, each of length K. More precisely, determine whether there exists an N \times K matrix P satisfying the following:

      - P_{1,1}, \dots, P_{1,K}, P_{2,1}, \dots, P_{N,K} is a permutation of 1,2,\dots,NK.
      - For each i=1,2,\dots,N and j=1,2,\dots,K-1, there is an edge connecting vertices P_{i,j} and P_{i,j+1}.

      Input

      The input is given from Standard Input in the following format:
      N K
      u_1 v_1
      u_2 v_2
      \vdots
      u_{NK-1} v_{NK-1}

      Output

      If it is possible to decompose the tree into N paths each of length K, print Yes. Otherwise, print No.

      Constraints


      - 1 \leq N
      - 1 \leq K
      - NK \leq 2 \times 10^5
      - 1 \leq u_i < v_i \leq NK
      - The given graph is a tree.
      - All input values are integers.

      Sample Input 1

      3 2
      1 2
      2 3
      3 4
      2 5
      5 6

      Sample Output 1

      Yes

      It can be decomposed into a path with vertices 1,2, a path with vertices 3,4, and a path with vertices 5,6.

      Sample Input 2

      3 2
      1 2
      2 3
      3 4
      2 5
      3 6

      Sample Output 2

      No

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 2\n1 2\n2 3\n3 4\n2 5\n5 6",
              "Yes"
          ],
          [
              "3 2\n1 2\n2 3\n3 4\n2 5\n3 6",
              "No"
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
