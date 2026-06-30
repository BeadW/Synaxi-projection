Feature: LiveCodeBench/atcoder/hard — Takahashi in Narrow Road
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a road extending east and west, and N persons are on the road.
      The road extends infinitely long to the east and west from a point called the origin.
      The i-th person (1\leq i\leq N) is initially at a position X_i meters east from the origin.
      The persons can move along the road to the east or west.
      Specifically, they can perform the following movement any number of times.

      - Choose one person. If there is no other person at the destination, move the chosen person 1 meter east or west.

      They have Q tasks in total, and the i-th task (1\leq i\leq Q) is as follows.

      - The T_i-th person arrives at coordinate G_i.

      Find the minimum total number of movements required to complete all Q tasks in order.

      Input

      The input is given from Standard Input in the following format:
      N
      X_1 X_2 \ldots X_N
      Q
      T_1 G_1
      T_2 G_2
      \vdots
      T_Q G_Q

      Output

      Print the answer.

      Constraints


      - 1\leq N\leq2\times10^5
      - 0\leq X_1 < X_2 < \dotsb < X_N \leq10^8
      - 1\leq Q\leq2\times10^5
      - 1\leq T_i\leq N\ (1\leq i\leq Q)
      - 0\leq G_i\leq10^8\ (1\leq i\leq Q)
      - All input values are integers.

      Sample Input 1

      5
      10 20 30 40 50
      4
      3 45
      4 20
      1 35
      2 60

      Sample Output 1

      239

      An optimal sequence of movements for the persons is as follows (the positions of the persons are not necessarily drawn to scale):

      For each task, the persons move as follows.

      - The 4th person moves 6 steps east, and the 3rd person moves 15 steps east.
      - The 2nd person moves 2 steps west, the 3rd person moves 26 steps west, and the 4th person moves 26 steps west.
      - The 4th person moves 18 steps east, the 3rd person moves 18 steps east, the 2nd person moves 18 steps east, and the 1st person moves 25 steps east.
      - The 5th person moves 13 steps east, the 4th person moves 24 steps east, the 3rd person moves 24 steps east, and the 2nd person moves 24 steps east.

      The total number of movements is 21+54+79+85=239.
      You cannot complete all tasks with a total movement count of 238 or less, so print 239.

      Sample Input 2

      8
      0 1 2 3 4 5 6 10000000

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5\n10 20 30 40 50\n4\n3 45\n4 20\n1 35\n2 60\n",
              "239\n"
          ],
          [
              "8\n0 1 2 3 4 5 6 100000000\n6\n1 100000000\n8 0\n1 100000000\n8 4\n1 100000000\n5 21006578\n",
              "4294967297\n"
          ],
          [
              "12\n1558 3536 3755 3881 4042 4657 5062 7558 7721 8330 8542 9845\n8\n9 1694\n7 3296\n12 5299\n5 5195\n5 5871\n1 2491\n8 1149\n8 2996\n",
              "89644\n"
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
