Feature: APPS/competition/3030 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a rooted tree with $n$ nodes. The nodes are labeled $1$ to $n$, and node $1$ is the root. Each node has a value $v_ i$.

      You would like to turn this tree into a heap. That is, you would like to choose the largest possible subset of nodes that satisfy this Heap Property: For every node pair $i$,$j$ in the subset, if node $i$ is an ancestor of node $j$ in the tree, then $v_ i > v_ j$. Note that equality is not allowed.

      Figure out the maximum number of nodes you can choose to form such a subset. The subset does not have to form a subtree.

      -----Input-----
      Each input will consist of a single test case. Note that your program may be run multiple times on different inputs. The first line of input will contain a single integer $n$ ($1 \le n \le 2 \cdot 10^5$), which is the number of nodes in the tree. The nodes are numbered $1$ to $n$.

      Each of the next $n$ lines will describe the nodes, in order from $i=1$ to $n$. They will each contain two integers $v_ i$ and $p_ i$, where $v_ i$ ($0 \le v_ i \le 10^9$) is the value in the node, and $p_ i$ ($0 \le p_ i < i$) is the index of its parent. Every node’s index will be strictly greater than its parent node’s index. Only node 1, the root, will have $p_1=0$, since it has no parent. For all other nodes ($i=2, 3, \ldots , n$), $1 \le p_ i < i$.

      -----Output-----
      Output a single integer representing the number of nodes in the largest subset satisfying the Heap Property.

      -----Examples-----
      Sample Input 1:
      5
      3 0
      3 1
      3 2
      3 3
      3 4
      Sample Output 1:
      1

      Sample Input 2:
      5
      4 0
      3 1
      2 2
      1 3
      0 4
      Sample Output 2:
      5

      Sample Input 3:
      6
      3 0
      1 1
      2 1
      3 1
      4 1
      5 1
      Sample Output 3:
      5

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "5\n3 0\n3 1\n3 2\n3 3\n3 4\n",
              "1\n"
          ],
          [
              "5\n4 0\n3 1\n2 2\n1 3\n0 4\n",
              "5\n"
          ],
          [
              "6\n3 0\n1 1\n2 1\n3 1\n4 1\n5 1\n",
              "5\n"
          ],
          [
              "11\n7 0\n8 1\n5 1\n5 2\n4 2\n3 2\n6 3\n6 3\n10 4\n9 4\n11 4\n",
              "7\n"
          ]
      ]


      def test_apps():
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

  Scenario: Agent solves the APPS problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py to read from stdin and write the correct answer to stdout so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
