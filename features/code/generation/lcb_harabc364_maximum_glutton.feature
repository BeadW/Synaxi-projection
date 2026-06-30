Feature: LiveCodeBench/atcoder/hard — Maximum Glutton
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Takahashi has prepared N dishes for Snuke.
      The dishes are numbered from 1 to N, and dish i has a sweetness of A_i and a saltiness of B_i.
      Takahashi can arrange these dishes in any order he likes.
      Snuke will eat the dishes in the order they are arranged, but if at any point the total sweetness of the dishes he has eaten so far exceeds X or the total saltiness exceeds Y, he will not eat any further dishes.
      Takahashi wants Snuke to eat as many dishes as possible.
      Find the maximum number of dishes Snuke will eat if Takahashi arranges the dishes optimally.

      Input

      The input is given from Standard Input in the following format:
      N X Y
      A_1 B_1
      A_2 B_2
      \vdots
      A_N B_N

      Output

      Print the answer as an integer.

      Constraints


      - 1 \leq N \leq 80
      - 1 \leq A_i, B_i \leq 10000
      - 1 \leq X, Y \leq 10000
      - All input values are integers.

      Sample Input 1

      4 8 4
      1 5
      3 2
      4 1
      5 3

      Sample Output 1

      3

      Consider the scenario where Takahashi arranges the dishes in the order 2, 3, 1, 4.

      - First, Snuke eats dish 2. The total sweetness so far is 3, and the total saltiness is 2.
      - Next, Snuke eats dish 3. The total sweetness so far is 7, and the total saltiness is 3.
      - Next, Snuke eats dish 1. The total sweetness so far is 8, and the total saltiness is 8.
      - The total saltiness has exceeded Y=4, so Snuke will not eat any further dishes.

      Thus, in this arrangement, Snuke will eat three dishes.
      No matter how Takahashi arranges the dishes, Snuke will not eat all four dishes, so the answer is 3.

      Sample Input 2

      2 1 1
      3 2
      3 2

      Sample Output 2

      1

      Sample Input 3

      2 100 100
      3 2
      3 2

      Sample Output 3

      2

      Sample Input 4

      6 364 463
      230 381
      154 200
      328 407
      339 94
      193 10
      115 309

      Sample Output 4

      3

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "4 8 4\n1 5\n3 2\n4 1\n5 3\n",
              "3\n"
          ],
          [
              "2 1 1\n3 2\n3 2\n",
              "1\n"
          ],
          [
              "2 100 100\n3 2\n3 2\n",
              "2\n"
          ],
          [
              "6 364 463\n230 381\n154 200\n328 407\n339 94\n193 10\n115 309\n",
              "3\n"
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
