Feature: LiveCodeBench/atcoder/hard — 7x7x7
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      In a coordinate space, we want to place three cubes with a side length of 7 so that the volumes of the regions contained in exactly one, two, three cube(s) are V_1, V_2, V_3, respectively.

      For three integers a, b, c, let C(a,b,c) denote the cubic region represented by (a\leq x\leq a+7) \land (b\leq y\leq b+7) \land (c\leq z\leq c+7).
      Determine whether there are nine integers a_1, b_1, c_1, a_2, b_2, c_2, a_3, b_3, c_3 that satisfy all of the following conditions, and find one such tuple if it exists.

      - |a_1|, |b_1|, |c_1|, |a_2|, |b_2|, |c_2|, |a_3|, |b_3|, |c_3| \leq 100
      - Let C_i = C(a_i, b_i, c_i)\ (i=1,2,3).
      - The volume of the region contained in exactly one of C_1, C_2, C_3 is V_1.
      - The volume of the region contained in exactly two of C_1, C_2, C_3 is V_2.
      - The volume of the region contained in all of C_1, C_2, C_3 is V_3.

      Input

      The input is given from Standard Input in the following format:
      V_1 V_2 V_3

      Output

      If no nine integers a_1, b_1, c_1, a_2, b_2, c_2, a_3, b_3, c_3 satisfy all of the conditions in the problem statement, print No. Otherwise, print such integers in the following format. If multiple solutions exist, you may print any of them.
      Yes
      a_1 b_1 c_1 a_2 b_2 c_2 a_3 b_3 c_3

      Constraints


      - 0 \leq V_1, V_2, V_3 \leq 3 \times 7^3
      - All input values are integers.

      Sample Input 1

      840 84 7

      Sample Output 1

      Yes
      0 0 0 0 6 0 6 0 0

      Consider the case (a_1, b_1, c_1, a_2, b_2, c_2, a_3, b_3, c_3) = (0, 0, 0, 0, 6, 0, 6, 0, 0).

      The figure represents the positional relationship of C_1, C_2, and C_3, corresponding to the orange, cyan, and green cubes, respectively.
      Here,

      - All of |a_1|, |b_1|, |c_1|, |a_2|, |b_2|, |c_2|, |a_3|, |b_3|, |c_3| are not greater than 100.
      - The region contained in all of C_1, C_2, C_3 is (6\leq x\leq 7)\land (6\leq y\leq 7) \land (0\leq z\leq 7), with a volume of (7-6)\times(7-6)\times(7-0)=7.
      - The region contained in exactly two of C_1, C_2, C_3 is ((0\leq x < 6)\land (6\leq y\leq 7) \land (0\leq z\leq 7))\lor((6\leq 

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "840 84 7\n",
              "Yes\n0 0 0 0 6 0 6 0 0\n"
          ],
          [
              "343 34 3\n",
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
