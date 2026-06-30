Feature: LiveCodeBench/atcoder/hard — Fraction Line
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      For a positive rational number x, define f(x) as follows:

      Express x as \dfrac{P}{Q} using coprime positive integers P and Q. f(x) is defined as the value P\times Q.

      You are given a positive integer N and a sequence A=(A_1,A_2,\dots,A_{N-1}) of positive integers of length N-1.
      We call a sequence S=(S_1,S_2,\dots,S_N) of positive integers of length N a good sequence if it satisfies all of the following conditions:

      - For every integer i with 1\leq i\leq N-1, it holds that f\left(\dfrac{S_i}{S_{i+1}}\right)=A_i.
      - \gcd(S_1,S_2,\dots,S_N)=1.

      Define the score of a sequence as the product of all its elements.
      It can be proved that there are finitely many good sequences. Find the sum, modulo 998244353, of the scores of all good sequences.

      Input

      The input is given from Standard Input in the following format:
      N
      A_1 A_2 \dots A_{N-1}

      Output

      Print the sum, modulo 998244353, of the scores of all good sequences.

      Constraints


      - 2\leq N\leq 1000
      - 1\leq A_i\leq 1000 (1\leq i\leq N-1)
      - All input values are integers.

      Sample Input 1

      6
      1 9 2 2 9

      Sample Output 1

      939634344

      For example, both (2,2,18,9,18,2) and (18,18,2,1,2,18) are good sequences, and both have a score of 23328.
      There are a total of 16 good sequences, and the sum of the scores of all of them is 939634344.

      Sample Input 2

      2
      9

      Sample Output 2

      18

      There are 2 good sequences, both with a score of 9.

      Sample Input 3

      25
      222 299 229 22 999 922 99 992 22 292 222 229 992 922 22 992 222 222 99 29 92 999 2 29

      Sample Output 3

      192457116

      Do not forget to compute the sum modulo 998244353.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "6\n1 9 2 2 9",
              "939634344"
          ],
          [
              "2\n9",
              "18"
          ],
          [
              "25\n222 299 229 22 999 922 99 992 22 292 222 229 992 922 22 992 222 222 99 29 92 999 2 29",
              "192457116"
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
