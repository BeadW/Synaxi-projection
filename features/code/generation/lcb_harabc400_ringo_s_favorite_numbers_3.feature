Feature: LiveCodeBench/atcoder/hard — Ringo's Favorite Numbers 3
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      A positive integer N is a 400 number if and only if it satisfies both of the following two conditions:

      - N has exactly 2 distinct prime factors.
      - For each prime factor p of N, p divides N an even number of times. More formally, the maximum non-negative integer k such that p^k divides N is even.

      Process Q queries. Each query gives you an integer A, so find the largest 400 number not exceeding A. Under the constraints of this problem, a 400 number not exceeding A always exists.

      Input

      The input is given from Standard Input in the following format:
      Q
      \text{query}_1
      \text{query}_2
      \vdots
      \text{query}_Q

      Here, \text{query}_i is the i-th query, given in the following format:
      A

      Output

      Print Q lines. The i-th line should contain the answer to the i-th query.

      Constraints


      - 1 \leq Q \leq 2 \times 10^5
      - For each query, 36 \leq A \leq 10^{12}.
      - All input values are integers.

      Sample Input 1

      5
      404
      36
      60
      1000000000000
      123456789

      Sample Output 1

      400
      36
      36
      1000000000000
      123454321

      Let us explain the first query.
      There are exactly 2 prime factors of 400: 2 and 5. Also, 2 divides 400 four times and 5 divides it twice, so 400 is a 400 number. None of 401, 402, 403, and 404 is a 400 number, so the answer is 400.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5\n404\n36\n60\n1000000000000\n123456789",
              "400\n36\n36\n1000000000000\n123454321"
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
