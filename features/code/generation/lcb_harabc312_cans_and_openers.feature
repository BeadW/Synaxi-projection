Feature: LiveCodeBench/atcoder/hard — Cans and Openers
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There are N items.
      Each of these is one of a pull-tab can, a regular can, or a can opener.
      The i-th item is described by an integer pair (T_i, X_i) as follows:  

      - If T_i = 0, the i-th item is a pull-tab can; if you obtain it, you get a happiness of X_i.
      - If T_i = 1, the i-th item is a regular can; if you obtain it and use a can opener against it, you get a happiness of X_i.
      - If T_i = 2, the i-th item is a can opener; it can be used against at most X_i cans.

      Find the maximum total happiness that you get by obtaining M items out of N.

      Input

      The input is given from Standard Input in the following format:
      N M
      T_1 X_1
      T_2 X_2
      \vdots
      T_N X_N

      Output

      Print the answer as an integer.

      Constraints


      - 1 \leq M \leq N \leq 2 \times 10^5
      - T_i is 0, 1, or 2.
      - 1 \leq X_i \leq 10^9
      - All input values are integers.

      Sample Input 1

      8 4
      0 6
      0 6
      1 3
      1 5
      1 15
      2 1
      2 10
      2 100

      Sample Output 1

      27

      If you obtain the 1-st, 2-nd, 5-th, and 7-th items, and use the 7-th item (a can opener) against the 5-th item, you will get a happiness of 6 + 6 + 15 = 27.
      There are no ways to obtain items to get a happiness of 28 or greater, but you can still get a happiness of 27 by obtaining the 6-th or 8-th items instead of the 7-th in the combination above.

      Sample Input 2

      5 5
      1 5
      1 5
      1 5
      1 5
      1 5

      Sample Output 2

      0

      Sample Input 3

      12 6
      2 2
      0 1
      0 9
      1 3
      1 5
      1 3
      0 4
      2 1
      1 8
      2 1
      0 1
      0 4

      Sample Output 3

      30

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "8 4\n0 6\n0 6\n1 3\n1 5\n1 15\n2 1\n2 10\n2 100\n",
              "27\n"
          ],
          [
              "5 5\n1 5\n1 5\n1 5\n1 5\n1 5\n",
              "0\n"
          ],
          [
              "12 6\n2 2\n0 1\n0 9\n1 3\n1 5\n1 3\n0 4\n2 1\n1 8\n2 1\n0 1\n0 4\n",
              "30\n"
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
