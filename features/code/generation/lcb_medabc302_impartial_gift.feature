Feature: LiveCodeBench/atcoder/medium — Impartial Gift
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Takahashi has decided to give one gift to Aoki and one gift to Snuke.
      There are N candidates of gifts for Aoki,
      and their values are A_1, A_2, \ldots,A_N.
      There are M candidates of gifts for Snuke,
      and their values are B_1, B_2, \ldots,B_M.  
      Takahashi wants to choose gifts so that the difference in values of the two gifts is at most D.
      Determine if he can choose such a pair of gifts.  If he can, print the maximum sum of values of the chosen gifts.

      Input

      The input is given from Standard Input in the following format:
      N M D
      A_1 A_2 \ldots A_N
      B_1 B_2 \ldots B_M

      Output

      If he can choose gifts to satisfy the condition,
      print the maximum sum of values of the chosen gifts.
      If he cannot satisfy the condition, print -1.

      Constraints


      - 1\leq N,M\leq 2\times 10^5
      - 1\leq A_i,B_i\leq 10^{18}
      - 0\leq D \leq 10^{18}
      - All values in the input are integers.

      Sample Input 1

      2 3 2
      3 10
      2 5 15

      Sample Output 1

      8

      The difference of values of the two gifts should be at most 2.
      If he gives a gift with value 3 to Aoki and another with value 5 to Snuke, the condition is satisfied, achieving the maximum possible sum of values.
      Thus, 3+5=8 should be printed.

      Sample Input 2

      3 3 0
      1 3 3
      6 2 7

      Sample Output 2

      -1

      He cannot choose gifts to satisfy the condition.
      Note that the candidates of gifts for a person may contain multiple gifts with the same value.

      Sample Input 3

      1 1 1000000000000000000
      1000000000000000000
      1000000000000000000

      Sample Output 3

      2000000000000000000

      Note that the answer may not fit into a 32-bit integer type.

      Sample Input 4

      8 6 1
      2 5 6 5 2 1 7 9
      7 2 5 5 2 4

      Sample Output 4

      14

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "2 3 2\n3 10\n2 5 15\n",
              "8\n"
          ],
          [
              "3 3 0\n1 3 3\n6 2 7\n",
              "-1\n"
          ],
          [
              "1 1 1000000000000000000\n1000000000000000000\n1000000000000000000\n",
              "2000000000000000000\n"
          ],
          [
              "8 6 1\n2 5 6 5 2 1 7 9\n7 2 5 5 2 4\n",
              "14\n"
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
