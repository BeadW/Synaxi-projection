Feature: LiveCodeBench/atcoder/hard — Xor Sigma Problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an integer sequence A=(A_1,\ldots,A_N) of length N. Find the value of the following expression:
      \displaystyle \sum_{i=1}^{N-1}\sum_{j=i+1}^N (A_i \oplus A_{i+1}\oplus \ldots \oplus A_j).

      Notes on bitwise XOR
      The bitwise XOR of non-negative integers A and B, denoted as A \oplus B, is defined as follows:
      - In the binary representation of A \oplus B, the digit at the 2^k (k \geq 0) position is 1 if and only if exactly one of the digits at the 2^k position in the binary representations of A and B is 1; otherwise, it is 0.
      For example, 3 \oplus 5 = 6 (in binary: 011 \oplus 101 = 110).
      In general, the bitwise XOR of k integers p_1, \dots, p_k is defined as (\cdots ((p_1 \oplus p_2) \oplus p_3) \oplus \cdots \oplus p_k).  It can be proved that this is independent of the order of p_1, \dots, p_k.

      Input

      The input is given from Standard Input in the following format:
      N 
      A_1 A_2 \ldots A_{N}

      Output

      Print the answer.

      Constraints


      - 2 \leq N \leq 2 \times 10^5
      - 1 \leq A_i \leq 10^8
      - All input values are integers.

      Sample Input 1

      3
      1 3 2

      Sample Output 1

      3

      A_1 \oplus A_2 = 2, A_1 \oplus A_2 \oplus A_3 = 0, and A_2 \oplus A_3 = 1, so the answer is 2 + 0 + 1 = 3.

      Sample Input 2

      7
      2 5 6 5 2 1 7

      Sample Output 2

      83

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n1 3 2\n",
              "3\n"
          ],
          [
              "7\n2 5 6 5 2 1 7\n",
              "83\n"
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
