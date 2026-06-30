Feature: LiveCodeBench/leetcode/hard — find-minimum-diameter-after-merging-two-trees
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There exist two undirected trees with n and m nodes, numbered from 0 to n - 1 and from 0 to m - 1, respectively. You are given two 2D integer arrays edges1 and edges2 of lengths n - 1 and m - 1, respectively, where edges1[i] = [a_i, b_i] indicates that there is an edge between nodes a_i and b_i in the first tree and edges2[i] = [u_i, v_i] indicates that there is an edge between nodes u_i and v_i in the second tree.
      You must connect one node from the first tree with another node from the second tree with an edge.
      Return the minimum possible diameter of the resulting tree.
      The diameter of a tree is the length of the longest path between any two nodes in the tree.
 
      Example 1:

      Input: edges1 = [[0,1],[0,2],[0,3]], edges2 = [[0,1]]
      Output: 3
      Explanation:
      We can obtain a tree of diameter 3 by connecting node 0 from the first tree with any node from the second tree.

      Example 2:


      Input: edges1 = [[0,1],[0,2],[0,3],[2,4],[2,5],[3,6],[2,7]], edges2 = [[0,1],[0,2],[0,3],[2,4],[2,5],[3,6],[2,7]]
      Output: 5
      Explanation:
      We can obtain a tree of diameter 5 by connecting node 0 from the first tree with node 0 from the second tree.

 
      Constraints:

      1 <= n, m <= 10^5
      edges1.length == n - 1
      edges2.length == m - 1
      edges1[i].length == edges2[i].length == 2
      edges1[i] = [a_i, b_i]
      0 <= a_i, b_i < n
      edges2[i] = [u_i, v_i]
      0 <= u_i, v_i < m
      The input is generated such that edges1 and edges2 represent valid trees.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[[0, 1], [0, 2], [0, 3]]\n[[0, 1]]",
              "3"
          ],
          [
              "[[0, 1], [0, 2], [0, 3], [2, 4], [2, 5], [3, 6], [2, 7]]\n[[0, 1], [0, 2], [0, 3], [2, 4], [2, 5], [3, 6], [2, 7]]",
              "5"
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
