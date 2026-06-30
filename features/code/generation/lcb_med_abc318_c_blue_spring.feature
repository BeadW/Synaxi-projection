Feature: LiveCodeBench/atcoder/medium — Blue Spring
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Takahashi is planning an N-day train trip.
      For each day, he can pay the regular fare or use a one-day pass.
      Here, for 1\leq i\leq N, the regular fare for the i-th day of the trip is F_i yen.
      On the other hand, a batch of D one-day passes is sold for P yen. You can buy as many passes as you want, but only in units of D.
      Each purchased pass can be used on any day, and it is fine to have some leftovers at the end of the trip.
      Find the minimum possible total cost for the N-day trip, that is, the cost of purchasing one-day passes plus the total regular fare for the days not covered by one-day passes.

      Input

      The input is given from Standard Input in the following format:
      N D P
      F_1 F_2 \ldots F_N

      Output

      Print the minimum possible total cost for the N-day trip.

      Constraints


      - 1\leq N\leq 2\times 10^5
      - 1\leq D\leq 2\times 10^5
      - 1\leq P\leq 10^9
      - 1\leq F_i\leq 10^9
      - All input values are integers.

      Sample Input 1

      5 2 10
      7 1 6 3 6

      Sample Output 1

      20

      If he buys just one batch of one-day passes and uses them for the first and third days, the total cost will be (10\times 1)+(0+1+0+3+6)=20, which is the minimum cost needed.
      Thus, print 20.

      Sample Input 2

      3 1 10
      1 2 3

      Sample Output 2

      6

      The minimum cost is achieved by paying the regular fare for all three days.

      Sample Input 3

      8 3 1000000000
      1000000000 1000000000 1000000000 1000000000 1000000000 1000000000 1000000000 1000000000

      Sample Output 3

      3000000000

      The minimum cost is achieved by buying three batches of one-day passes and using them for all eight days.
      Note that the answer may not fit into a 32-bit integer type.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5 2 10\n7 1 6 3 6\n",
              "20\n"
          ],
          [
              "3 1 10\n1 2 3\n",
              "6\n"
          ],
          [
              "8 3 1000000000\n1000000000 1000000000 1000000000 1000000000 1000000000 1000000000 1000000000 1000000000\n",
              "3000000000\n"
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
