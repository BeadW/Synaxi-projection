Feature: LiveCodeBench/atcoder/hard — Cost to Flip
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given two integer sequences of length N, A = (A_1, A_2, \ldots, A_N) and B = (B_1, B_2, \ldots, B_N), each consisting of 0 and 1.
      You can perform the following operation on A any number of times (possibly zero):

      - First, choose an integer i satisfying 1 \leq i \leq N, and flip the value of A_i (if the original value is 0, change it to 1; if it is 1, change it to 0).
      - Then, pay \sum_{k=1}^N A_k C_k yen as the cost of this operation.

      Note that the cost calculation in step 2 uses the A after the change in step 1.
      Print the minimum total cost required to make A identical to B.

      Input

      The input is given from Standard Input in the following format:
      N
      A_1 A_2 \ldots A_N
      B_1 B_2 \ldots B_N
      C_1 C_2 \ldots C_N

      Output

      Print the answer.

      Constraints


      - 1 \leq N \leq 2 \times 10^5
      - A_i, B_i \in {0, 1}
      - 1 \leq C_i \leq 10^6
      - All input values are integers.

      Sample Input 1

      4
      0 1 1 1
      1 0 1 0
      4 6 2 9

      Sample Output 1

      16

      Consider the following procedure:

      - First, flip A_4. Now, A = (0, 1, 1, 0). The cost of this operation is 0 \times 4 + 1 \times 6 + 1 \times 2 + 0 \times 9 = 8 yen.
      - Next, flip A_2. Now, A = (0, 0, 1, 0). The cost of this operation is 0 \times 4 + 0 \times 6 + 1 \times 2 + 0 \times 9 = 2 yen.
      - Finally, flip A_1. Now, A = (1, 0, 1, 0), which matches B. The cost of this operation is 1 \times 4 + 0 \times 6 + 1 \times 2 + 0 \times 9 = 6 yen.

      In this case, the total cost is 8 + 2 + 6 = 16 yen, which is the minimum possible.

      Sample Input 2

      5
      1 1 1 1 1
      1 1 1 1 1
      1 1 1 1 1

      Sample Output 2

      0

      A and B are already identical initially, so there is no need to perform any operations.

      Sample Input 3

      20
      1 1 1 1 0 0 1 1 0 0 0 1 0 1 0 1 1 0 1 0
      0 0 0 1 1 1 0 1 1 0 0 0 0 0 0 1 0 1 0 0
      52 73 97 72 54 15 79 67 13 55 65 22 36 90 84 46 1 2 27 8

      Sample Output 3

      2867

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "4\n0 1 1 1\n1 0 1 0\n4 6 2 9",
              "16"
          ],
          [
              "5\n1 1 1 1 1\n1 1 1 1 1\n1 1 1 1 1",
              "0"
          ],
          [
              "20\n1 1 1 1 0 0 1 1 0 0 0 1 0 1 0 1 1 0 1 0\n0 0 0 1 1 1 0 1 1 0 0 0 0 0 0 1 0 1 0 0\n52 73 97 72 54 15 79 67 13 55 65 22 36 90 84 46 1 2 27 8",
              "2867"
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
