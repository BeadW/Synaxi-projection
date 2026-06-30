Feature: LiveCodeBench/atcoder/hard — I Hate Sigma Problems
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a sequence of integers A = (A_1, A_2, \ldots, A_N) of length N.
                          Define f(l, r) as:

      - the number of distinct values in the subsequence (A_l, A_{l+1}, \ldots, A_r).

      Evaluate the following expression:

      \displaystyle \sum_{i=1}^{N}\sum_{j=i}^N f(i,j).

      Input


      The input is given from Standard Input in the following format:
      N
      A_1 \ldots A_N

      Output


      Print the answer.

      Constraints



      - 1\leq N\leq 2\times 10^5
      - 1\leq A_i\leq N
      - All input values are integers.

      Sample Input 1


      3
      1 2 2

      Sample Output 1


      8

      Consider f(1,2). The subsequence (A_1, A_2) = (1,2) contains 2
                          distinct values, so f(1,2)=2.
      Consider f(2,3). The subsequence (A_2, A_3) = (2,2) contains 1
                          distinct value, so f(2,3)=1.
      The sum of f is 8.

      Sample Input 2


      9
      5 4 2 2 3 2 4 4 1

      Sample Output 2


      111

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n1 2 2\n",
              "8\n"
          ],
          [
              "9\n5 4 2 2 3 2 4 4 1\n",
              "111\n"
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
