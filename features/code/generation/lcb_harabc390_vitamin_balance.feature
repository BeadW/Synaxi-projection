Feature: LiveCodeBench/atcoder/hard — Vitamin Balance
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There are N foods, each containing exactly one of vitamins 1, 2, and 3.
      Specifically, eating the i-th food gives you A_i units of vitamin V_i, and C_i calories.
      Takahashi can choose any subset of these N foods as long as the total calorie consumption does not exceed X.
      Find the maximum possible value of this: the minimum intake among vitamins 1, 2, and 3.

      Input

      The input is given from Standard Input in the following format:
      N X
      V_1 A_1 C_1
      V_2 A_2 C_2
      \vdots
      V_N A_N C_N

      Output

      Print the maximum possible value of "the minimum intake among vitamins 1, 2, and 3" when the total calories consumed is at most X.

      Constraints


      - 1 \leq N \leq 5000
      - 1 \leq X \leq 5000
      - 1 \leq V_i \leq 3
      - 1 \leq A_i \leq 2 \times 10^5
      - 1 \leq C_i \leq X
      - All input values are integers.

      Sample Input 1

      5 25
      1 8 5
      2 3 5
      2 7 10
      3 2 5
      3 3 10

      Sample Output 1

      3

      Each food provides the following if eaten:

      - 1st food: 8 units of vitamin 1, and 5 calories
      - 2nd food: 3 units of vitamin 2, and 5 calories
      - 3rd food: 7 units of vitamin 2, and 10 calories
      - 4th food: 2 units of vitamin 3, and 5 calories
      - 5th food: 3 units of vitamin 3, and 10 calories

      Eating the 1st, 2nd, 4th, and 5th foods gives 8 units of vitamin 1, 3 units of vitamin 2, 5 units of vitamin 3, and 25 calories.
      In this case, the minimum among the three vitamin intakes is 3 (vitamin 2).
      It is impossible to get 4 or more units of each vitamin without exceeding 25 calories, so the answer is 3.

      Sample Input 2

      2 5000
      1 200000 1
      2 200000 1

      Sample Output 2

      0

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5 25\n1 8 5\n2 3 5\n2 7 10\n3 2 5\n3 3 10",
              "3"
          ],
          [
              "2 5000\n1 200000 1\n2 200000 1",
              "0"
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
