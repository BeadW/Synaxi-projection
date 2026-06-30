Feature: APPS/competition/3031 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      The Transit Authority of Greater Podunk is planning its holiday decorations. They want to create an illuminated display of their light rail map in which each stretch of track between stations can be illuminated in one of several colors. 

      At periodic intervals, the controlling software will choose two stations at random and illuminate all of the segments connecting those two stations. By design, for any two stations on the Greater Podunk Railway, there is a unique path connecting the two.

      For maximum color and cheer, the display designers want to avoid having two adjacent segments of track lighting up in the same color. They fear, however, that they may have lost track of this guideline in the process of building the display. One of them has gone so far as to propose a means of measuring just how far from that ideal they may have fallen.

      -----Description-----
      You are given a tree with $n$ nodes (stations), conveniently numbered from $1$ to $n$. Each edge in this tree has one of $n$ colors. A path in this tree is called a rainbow if all adjacent edges in the path have different colors. Also, a node is called good if every simple path with that node as one of its endpoints is a rainbow path. (A simple path is a path that does not repeat any vertex or edge.)

      Find all the good nodes in the given tree.

      -----Input-----
      The first line of input contains a single integer $n$ ($1 \le n \le 50000$).

      Each of the next $n-1$ lines contains three space-separated integers $a_ i$, $b_ i$, and $c_ i$ ($1 \le a_ i, b_ i, c_ i \le n$; $a_ i \ne b_ i$), describing an edge of color $c_ i$ that connects nodes $a_ i$ and $b_ i$.

      It is guaranteed that the given edges form a tree.

      -----Output-----
      On the first line of the output, print $k$, the number of good nodes.

      In the next $k$ lines, print the indices of all good nodes in numerical order, one per line.

      -----Examples-----
      (For the first sample, node $3$ is good because all paths that have node $3$ as an endpoint are rainbow. In 
      ...(truncated)

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "8\n1 3 1\n2 3 1\n3 4 3\n4 5 4\n5 6 3\n6 7 2\n6 8 2\n",
              "4\n3\n4\n5\n6\n"
          ],
          [
              "8\n1 2 2\n1 3 1\n2 4 3\n2 7 1\n3 5 2\n5 6 2\n7 8 1\n",
              "0\n"
          ],
          [
              "9\n1 2 2\n1 3 1\n1 4 5\n1 5 5\n2 6 3\n3 7 3\n4 8 1\n5 9 2\n",
              "5\n1\n2\n3\n6\n7\n"
          ],
          [
              "10\n9 2 1\n9 3 1\n9 4 2\n9 5 2\n9 1 3\n9 6 4\n1 8 5\n1 10 5\n6 7 9\n",
              "4\n1\n6\n7\n9\n"
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
