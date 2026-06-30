Feature: LiveCodeBench/atcoder/hard — Water Tank
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a sequence of positive integers of length N: H=(H _ 1,H _ 2,\dotsc,H _ N).
      There is a sequence of non-negative integers of length N+1: A=(A _ 0,A _ 1,\dotsc,A _ N). Initially, A _ 0=A _ 1=\dotsb=A _ N=0.
      Perform the following operations repeatedly on A:

      - Increase the value of A _ 0 by 1.
      - For i=1,2,\ldots,N in this order, perform the following operation:
      - If A _ {i-1}\gt A _ i and A _ {i-1}\gt H _ i, decrease the value of A _ {i-1} by 1 and increase the value of A _ i by 1.



      For each i=1,2,\ldots,N, find the number of operations before A _ i>0 holds for the first time.

      Input

      The input is given from Standard Input in the following format:
      N
      H _ 1 H _ 2 \dotsc H _ N

      Output

      Print the answers for i=1,2,\ldots,N in a single line, separated by spaces.

      Constraints


      - 1\leq N\leq2\times10 ^ 5
      - 1\leq H _ i\leq10 ^ 9\ (1\leq i\leq N)
      - All input values are integers.

      Sample Input 1

      5
      3 1 4 1 5

      Sample Output 1

      4 5 13 14 26

      The first five operations go as follows.
      Here, each row corresponds to one operation, with the leftmost column representing step 1 and the others representing step 2.

      From this diagram, A _ 1\gt0 holds for the first time after the 4th operation, and A _ 2\gt0 holds for the first time after the 5th operation.
      Similarly, the answers for A _ 3, A _ 4, A _ 5 are 13, 14, 26, respectively.
      Therefore, you should print 4 5 13 14 26.

      Sample Input 2

      6
      1000000000 1000000000 1000000000 1000000000 1000000000 1000000000

      Sample Output 2

      1000000001 2000000001 3000000001 4000000001 5000000001 6000000001

      Note that the values to be output may not fit within a 32-bit integer.

      Sample Input 3

      15
      748 169 586 329 972 529 432 519 408 587 138 249 656 114 632

      Sample Output 3

      749 918 1921 2250 4861 5390 5822 6428 6836 7796 7934 8294 10109 10223 11373

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5\n3 1 4 1 5\n",
              "4 5 13 14 26 \n"
          ],
          [
              "6\n1000000000 1000000000 1000000000 1000000000 1000000000 1000000000\n",
              "1000000001 2000000001 3000000001 4000000001 5000000001 6000000001 \n"
          ],
          [
              "15\n748 169 586 329 972 529 432 519 408 587 138 249 656 114 632\n",
              "749 918 1921 2250 4861 5390 5822 6428 6836 7796 7934 8294 10109 10223 11373 \n"
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
