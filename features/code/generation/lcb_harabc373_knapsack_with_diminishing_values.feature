Feature: LiveCodeBench/atcoder/hard — Knapsack with Diminishing Values
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There are N types of items. The i-th type of item has a weight of w_i and a value of v_i. Each type has 10^{10} items available.
      Takahashi is going to choose some items and put them into a bag with capacity W. He wants to maximize the value of the selected items while avoiding choosing too many items of the same type. Hence, he defines the happiness of choosing k_i items of type i as k_i v_i - k_i^2. He wants to choose items to maximize the total happiness over all types while keeping the total weight at most W. Calculate the maximum total happiness he can achieve.

      Input

      The input is given from Standard Input in the following format:
      N W
      w_1 v_1
      w_2 v_2
      \vdots
      w_N v_N

      Output

      Print the answer.

      Constraints


      - 1 \leq N \leq 3000
      - 1 \leq W \leq 3000
      - 1 \leq w_i \leq W
      - 1 \leq v_i \leq 10^9
      - All input values are integers.

      Sample Input 1

      2 10
      3 4
      3 2

      Sample Output 1

      5

      By choosing 2 items of type 1 and 1 item of type 2, the total happiness can be 5, which is optimal.
      Here, the happiness for type 1 is 2 \times 4 - 2^2 = 4, and the happiness for type 2 is 1 \times 2 - 1^2 = 1.
      The total weight is 9, which is within the capacity 10.

      Sample Input 2

      3 6
      1 4
      2 3
      2 7

      Sample Output 2

      14

      Sample Input 3

      1 10
      1 7

      Sample Output 3

      12

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "2 10\n3 4\n3 2\n",
              "5\n"
          ],
          [
              "3 6\n1 4\n2 3\n2 7\n",
              "14\n"
          ],
          [
              "1 10\n1 7\n",
              "12\n"
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
