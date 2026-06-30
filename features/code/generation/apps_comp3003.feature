Feature: APPS/competition/3003 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      To address the impending STEM shortage early on, your local elementary school decided to teach graph theory to its kindergarten students! To tap into their age-specific skills, the students are asked to color the vertices of a graph with colors of their own choosing. There is one constraint, however: they cannot use the same color for two vertices if those vertices are connected by an edge. Furthermore, they are asked to use as few different colors as possible. The illustration shows a few examples of student work. 

      There is one problem, as you can imagine: there is no money to train teachers to grade these students’ submissions! Thus, your task is to write a program that computes the sample solutions for the graphs given on each work sheet!

      -----Input-----
      The input consists of a description of a single graph. The first line contains a number $N$ ($2 \le N \le 11$), the number of vertices in the graph. Vertices are numbered $0 \ldots N-1$. The following $N$ lines contain one or more numbers each. The $i^{th}$ line contains a list of vertex numbers ${ v_ j }$, denoting edges from $v_ i$ to each $v_ j$ in the list. You may assume that the graph is connected (there is a path between any two pairs of vertices).

      -----Output-----
      Output the minimum number of colors required to color all vertices of the graph such that no vertices that share an edge are colored using the same color!

      The sample input corresponds to the graphs shown on the illustration.

      -----Examples-----
      Sample Input 1:
      4
      1 2
      0 2 3
      0 1
      1
      Sample Output 1:
      3

      Sample Input 2:
      5
      2 3 4
      2 3 4
      0 1
      0 1
      0 1
      Sample Output 2:
      2

      Sample Input 3:
      6
      1 3
      0 2 4
      1 5
      0 4
      1 3 5
      2 4
      Sample Output 3:
      2

      Sample Input 4:
      4
      1 2 3
      0 2 3
      0 1 3
      0 1 2
      Sample Output 4:
      4

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "4\n1 2\n0 2 3\n0 1\n1\n",
              "3\n"
          ],
          [
              "5\n2 3 4\n2 3 4\n0 1\n0 1\n0 1\n",
              "2\n"
          ],
          [
              "6\n1 3\n0 2 4\n1 5\n0 4\n1 3 5\n2 4\n",
              "2\n"
          ],
          [
              "4\n1 2 3\n0 2 3\n0 1 3\n0 1 2\n",
              "4\n"
          ],
          [
              "5\n1 2\n0 2 3\n0 1 4\n1 4\n2 3\n",
              "3\n"
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
