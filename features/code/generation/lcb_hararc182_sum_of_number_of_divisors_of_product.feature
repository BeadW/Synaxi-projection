Feature: LiveCodeBench/atcoder/hard — Sum of Number of Divisors of Product
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      An integer sequence of length between 1 and N, inclusive, where each element is between 1 and M, inclusive, is called a good sequence.
      The score of a good sequence is defined as the number of positive divisors of X, where X is the product of the elements in the sequence.
      There are \displaystyle \sum_{k=1}^{N}M^k good sequences. Find the sum of the scores of all those sequences modulo 998244353.

      Input

      The input is given from Standard Input in the following format:
      N M

      Output

      Print the answer as an integer.

      Constraints


      - 1 \leq N \leq 10^{18}
      - 1 \leq M \leq 16
      - All input values are integers.

      Sample Input 1

      1 7

      Sample Output 1

      16

      There are seven good sequences: (1),(2),(3),(4),(5),(6),(7). Their scores are 1,2,2,3,2,4,2, respectively, so the answer is 1+2+2+3+2+4+2=16.

      Sample Input 2

      3 11

      Sample Output 2

      16095

      For example, (8,11) and (1,8,2) are good sequences. Here is the process of calculating their scores:

      - The product of the elements in (8,11) is 8 \times 11 = 88. 88 has eight positive divisors: 1,2,4,8,11,22,44,88, so the score of (8,11) is 8.
      - The product of the elements in (1,8,2) is 1 \times 8 \times 2 = 16. 16 has five positive divisors: 1,2,4,8,16, so the score of (1,8,2) is 5.

      Sample Input 3

      81131 14

      Sample Output 3

      182955659

      Remember to take the result modulo 998244353.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "1 7\n",
              "16\n"
          ],
          [
              "3 11\n",
              "16095\n"
          ],
          [
              "81131 14\n",
              "182955659\n"
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
