Feature: LiveCodeBench/atcoder/medium — Festival
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      The AtCoder Kingdom holds a festival for N days. On M of these days, namely on the A_1-th, A_2-th, \dots, A_M-th days, fireworks will be launched. It is guaranteed that fireworks will be launched on the last day of the festival. (In other words, A_M=N is guaranteed.)
      For each i=1,2,\dots,N, solve the following problem.

      - How many days later from the i-th day will fireworks be launched for the first time on or after the i-th day? If fireworks are launched on the i-th day, it is considered to be 0 days later.

      Input

      The input is given from Standard Input in the following format:
      N M
      A_1 A_2 \dots A_M

      Output

      Print N lines.
      The i-th line (1 \le i \le N) should contain an integer representing the number of days from the i-th day until fireworks are launched for the first time on or after the i-th day.

      Constraints


      - 1 \le M \le N \le 2 \times 10^5
      - 1 \le A_1 < A_2 < \dots < A_M = N
      - All input values are integers.

      Sample Input 1

      3 2
      2 3

      Sample Output 1

      1
      0
      0

      The kingdom holds a festival for 3 days, and fireworks are launched on the 2-nd and 3-rd days.

      - From the 1-st day, the first time fireworks are launched is the 2-nd day of the festival, which is 1 day later.
      - From the 2-nd day, the first time fireworks are launched is the 2-nd day of the festival, which is 0 days later.
      - From the 3-rd day, the first time fireworks are launched is the 3-rd day of the festival, which is 0 days later.

      Sample Input 2

      8 5
      1 3 4 7 8

      Sample Output 2

      0
      1
      0
      0
      2
      1
      0
      0

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 2\n2 3\n",
              "1\n0\n0\n"
          ],
          [
              "8 5\n1 3 4 7 8\n",
              "0\n1\n0\n0\n2\n1\n0\n0\n"
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
