Feature: LiveCodeBench/atcoder/hard — Yet Another Sigma Problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      For strings x and y, define f(x, y) as follows:

      - f(x, y) is the length of the longest common prefix of x and y.

      You are given N strings (S_1, \ldots, S_N) consisting of lowercase English letters. Find the value of the following expression:
      \displaystyle \sum_{i=1}^{N-1}\sum_{j=i+1}^N f(S_i,S_j).

      Input

      The input is given from Standard Input in the following format:
      N 
      S_1 \ldots S_N

      Output

      Print the answer.

      Constraints


      - 2 \leq N \leq 3\times 10^5
      - S_i is a string consisting of lowercase English letters.
      - 1 \leq |S_i|
      - |S_1|+|S_2|+\ldots+|S_N|\leq 3\times 10^5
      - All input numbers are integers.

      Sample Input 1

      3
      ab abc arc

      Sample Output 1

      4


      - f(S_1,S_2)=2 
      - f(S_1,S_3)=1 
      - f(S_2,S_3)=1 

      Thus, the answer is f(S_1,S_2) + f(S_1,S_3) + f(S_2,S_3) = 4.

      Sample Input 2

      11
      ab bb aaa bba baba babb aaaba aabbb a a b

      Sample Output 2

      32

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\nab abc arc\n",
              "4\n"
          ],
          [
              "11\nab bb aaa bba baba babb aaaba aabbb a a b\n",
              "32\n"
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
