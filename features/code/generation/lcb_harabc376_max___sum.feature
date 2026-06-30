Feature: LiveCodeBench/atcoder/hard — Max × Sum
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given sequences of length N: A = (A_1, A_2, \dots, A_N) and B = (B_1, B_2, \dots, B_N).
      Let S be a subset of \lbrace1, 2, \dots, N\rbrace of size K.
      Here, find the minimum possible value of the following expression:

      \displaystyle \left(\max_{i \in S} A_i\right) \times \left(\sum_{i \in S} B_i\right).

      You are given T test cases; solve each of them.

      Input

      The input is given from Standard Input in the following format. Here, \mathrm{case}_i denotes the i-th test case.
      T
      \mathrm{case}_1
      \mathrm{case}_2
      \vdots
      \mathrm{case}_T

      Each test case is given in the following format:
      N K
      A_1 A_2 \dots A_N
      B_1 B_2 \dots B_N

      Output

      Print T lines. The i-th line should contain the answer for the i-th test case.

      Constraints


      - 1 \leq T \leq 2 \times 10^5
      - 1 \leq K \leq N \leq 2 \times 10^5
      - 1 \leq A_i, B_i \leq 10^6
      - The sum of N over all test cases is at most 2 \times 10^5.
      - All input values are integers.

      Sample Input 1

      3
      3 2
      3 7 6
      9 2 4
      5 3
      6 4 1 5 9
      8 6 5 1 7
      10 6
      61 95 61 57 69 49 46 47 14 43
      39 79 48 92 90 76 30 16 30 94

      Sample Output 1

      42
      60
      14579

      In the first test case, for S = \{2, 3\}, the value of the expression is 7 \times (2 + 4) = 42, which is the minimum.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n3 2\n3 7 6\n9 2 4\n5 3\n6 4 1 5 9\n8 6 5 1 7\n10 6\n61 95 61 57 69 49 46 47 14 43\n39 79 48 92 90 76 30 16 30 94\n",
              "42\n60\n14579\n"
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
