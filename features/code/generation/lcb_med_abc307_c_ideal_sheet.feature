Feature: LiveCodeBench/atcoder/medium — Ideal Sheet
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Takahashi has two sheets A and B, each composed of black squares and transparent squares, and an infinitely large sheet C composed of transparent squares.
      There is also an ideal sheet X for Takahashi composed of black squares and transparent squares.
      The sizes of sheets A, B, and X are H_A rows \times W_A columns, H_B rows \times W_B columns, and H_X rows \times W_X columns, respectively.
      The squares of sheet A are represented by H_A strings of length W_A, A_1, A_2, \ldots, A_{H_A} consisting of . and #.
      If the j-th character (1\leq j\leq W_A) of A_i (1\leq i\leq H_A) is ., the square at the i-th row from the top and j-th column from the left is transparent; if it is #, that square is black.
      Similarly, the squares of sheets B and X are represented by H_B strings of length W_B, B_1, B_2, \ldots, B_{H_B}, and H_X strings of length W_X, X_1, X_2, \ldots, X_{H_X}, respectively.
      Takahashi's goal is to create sheet X using all black squares in sheets A and B by following the steps below with sheets A, B, and C.

      - Paste sheets A and B onto sheet C along the grid. Each sheet can be pasted anywhere by translating it, but it cannot be cut or rotated.
      - Cut out an H_X\times W_X area from sheet C along the grid. Here, a square of the cut-out sheet will be black if a black square of sheet A or B is pasted there, and transparent otherwise.

      Determine whether Takahashi can achieve his goal by appropriately choosing the positions where the sheets are pasted and the area to cut out, that is, whether he can satisfy both of the following conditions.

      - The cut-out sheet includes all black squares of sheets A and B. The black squares of sheets A and B may overlap on the cut-out sheet.
      - The cut-out sheet coincides sheet X without rotating or flipping.

      Input

      The input is given from Standard Input in the following format:
      H_A W_A
      A_1
      A_2
      \vdots
      A_{H_A}
      H_B W_B
      B_1
      B_2
      \vdots
      B_{H_B}
      H_X W_X
      X_1
      X_2
      \vdots
      X_{H_X}

      Output

      If Takahashi can achieve the goal described in the problem stat

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 5\n#.#..\n.....\n.#...\n2 2\n#.\n.#\n5 3\n...\n#.#\n.#.\n.#.\n...\n",
              "Yes\n"
          ],
          [
              "2 2\n#.\n.#\n2 2\n#.\n.#\n2 2\n##\n##\n",
              "No\n"
          ],
          [
              "1 1\n#\n1 2\n##\n1 1\n#\n",
              "No\n"
          ],
          [
              "3 3\n###\n...\n...\n3 3\n#..\n#..\n#..\n3 3\n..#\n..#\n###\n",
              "Yes\n"
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
