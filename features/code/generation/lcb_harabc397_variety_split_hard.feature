Feature: LiveCodeBench/atcoder/hard — Variety Split Hard
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      This problem is a harder version of Problem C. Here, the sequence is split into three subarrays.

      You are given an integer sequence of length N: A = (A_1, A_2, \ldots, A_N).
      When splitting A at two positions into three non-empty (contiguous) subarrays, find the maximum possible sum of the counts of distinct integers in those subarrays.
      More formally, find the maximum sum of the following three values for a pair of integers (i,j) such that 1 \leq i < j \leq N-1: the count of distinct integers in (A_1, A_2, \ldots, A_i), the count of distinct integers in (A_{i+1},A_{i+2},\ldots,A_j), and the count of distinct integers in (A_{j+1},A_{j+2},\ldots,A_{N}).

      Input

      The input is given from Standard Input in the following format:
      N
      A_1 A_2 \ldots A_N

      Output

      Print the answer.

      Constraints


      - 3 \leq N \leq 3 \times 10^5
      - 1 \leq A_i \leq N (1 \leq i \leq N)
      - All input values are integers.

      Sample Input 1

      5
      3 1 4 1 5

      Sample Output 1

      5

      If we let (i,j) = (2,4) to split the sequence into three subarrays (3,1), (4,1), (5), the counts of distinct integers in those subarrays are 2, 2, 1, respectively, for a total of 5. This sum cannot be greater than 5, so the answer is 5. Other partitions, such as (i,j) = (1,3), (2,3), (3,4), also achieve this sum.

      Sample Input 2

      10
      2 5 6 4 4 1 1 3 1 4

      Sample Output 2

      9

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5\n3 1 4 1 5",
              "5"
          ],
          [
              "10\n2 5 6 4 4 1 1 3 1 4",
              "9"
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
