Feature: LiveCodeBench/atcoder/hard — ABC Puzzle
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an integer N and strings R and C of length N consisting of A, B, and C. Solve the following problem.
      There is a N \times N grid. All cells are initially empty.
      You can write at most one character from A, B, and C in each cell. (You can also leave the cell empty.)
      Determine if it is possible to satisfy all of the following conditions, and if it is possible, print one way to do so.

      - Each row and each column contain exactly one A, one B, and one C.
      - The leftmost character written in the i-th row matches the i-th character of R.
      - The topmost character written in the i-th column matches the i-th character of C.

      Input

      The input is given from Standard Input in the following format:
      N
      R
      C

      Output

      If there is no way to fill the grid to satisfy the conditions in the problem statement, print No in one line.
      Otherwise, print one such way to fill the grid in the following format:
      Yes
      A_1
      A_2
      \vdots
      A_N

      The first line should contain Yes.
      The i-th of the subsequent N lines should contain a string A_i of length N.

      - If the j-th character of A_i is ., it indicates that the cell in the i-th row from the top and the j-th column from the left is empty.
      - If the j-th character of A_i is A, it indicates that A is written in the cell in the i-th row from the top and the j-th column from the left.
      - If the j-th character of A_i is B, it indicates that B is written in the cell in the i-th row from the top and the j-th column from the left.
      - If the j-th character of A_i is C, it indicates that C is written in the cell in the i-th row from the top and the j-th column from the left.

      If there are multiple correct ways to fill the grid, you may print any of them.

      Constraints


      - N is an integer between 3 and 5, inclusive.
      - R and C are strings of length N consisting of A, B, and C.

      Sample Input 1

      5
      ABCBC
      ACAAB

      Sample Output 1

      Yes
      AC..B
      .BA.C
      C.BA.
      BA.C.
      ..CBA

      The grid in the output example satisfies all the following conditions, so it will be trea

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5\nABCBC\nACAAB\n",
              "Yes\nAC..B\n.BA.C\nC.BA.\nBA.C.\n..CBA\n"
          ],
          [
              "3\nAAA\nBBB\n",
              "No\n"
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
