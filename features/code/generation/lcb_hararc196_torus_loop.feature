Feature: LiveCodeBench/atcoder/hard — Torus Loop
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a grid of H rows and W columns.
      The rows are numbered 0,1,\ldots,H-1 from top to bottom, and the columns are numbered 0,1,\ldots,W-1 from left to right.
      Let (i,j) denote the cell at row i and column j.
      You are given H strings S_0, S_1, \ldots, S_{H-1}, each of which is of length W and consists of A and B.
      In each cell, one of the following two types of tiles is placed.
      Let S_{ij} denote the (j+1)-th character (0 \le j \le W-1) of the string S_i. The type of tile placed in cell (i,j) is S_{ij}.

      - Type A: A single line segment is drawn on the tile’s surface, connecting the midpoints of two adjacent edges.



      - Type B: A single line segment is drawn on the tile’s surface, connecting the midpoints of two opposite edges.


      These tiles can be freely rotated. When focusing only on the pattern formed by the line segments, there are four ways to rotate a Type-A tile and two ways to rotate a Type-B tile. Therefore, if we distinguish placements only by the pattern of line segments, the number of ways to place the tiles is 4^a \times 2^b, where a is the number of Type-A tiles and b is the number of Type-B tiles.
      Among these ways, print the number, modulo 998244353, of ways such that the line segments on the tiles have no dead ends when viewing the grid as a torus.
      Here, "the line segments on the tiles have no dead ends when viewing the grid as a torus" if and only if the following two conditions are satisfied for every cell (i,j):

      - Both of the following exist, or neither of the following exists:
      - the line segment drawn in the cell (i,j), whose endpoint is the midpoint of the right edge of the cell (i,j)
      - the line segment drawn in the cell (i,(j+1)\bmod W), whose endpoint is the midpoint of the left edge of the cell (i,(j+1)\bmod W)


      - Both of the following exist, or neither of the following exists:
      - the line segment drawn in the cell (i,j), whose endpoint is the midpoint of the bottom edge of the cell (i,j)
      - the line segment drawn in the cell ((i+1)\bmod H,j), 

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n3 3\nAAB\nAAB\nBBB\n3 3\nBBA\nABA\nAAB\n3 4\nBAAB\nBABA\nBBAA",
              "2\n0\n2"
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
