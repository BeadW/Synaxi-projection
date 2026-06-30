Feature: LiveCodeBench/atcoder/hard — Set Add Query
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is an integer sequence A=(A_1,A_2,\ldots,A_N) of length N, where all elements are initially set to 0. Also, there is a set S, which is initially empty.
      Perform the following Q queries in order. Find the value of each element in the sequence A after processing all Q queries. The i-th query is in the following format:

      - An integer x_i is given. If the integer x_i is contained in S, remove x_i from S. Otherwise, insert x_i to S. Then, for each j=1,2,\ldots,N, add |S| to A_j if j\in S.

      Here, |S| denotes the number of elements in the set S. For example, if S=\lbrace 3,4,7\rbrace, then |S|=3.

      Input

      The input is given from Standard Input in the following format:
      N Q
      x_1 x_2 \ldots x_Q

      Output

      Print the sequence A after processing all queries in the following format:
      A_1 A_2 \ldots A_N

      Constraints


      - 1\leq N,Q\leq 2\times10^5
      - 1\leq x_i\leq N
      - All given numbers are integers.

      Sample Input 1

      3 4
      1 3 3 2

      Sample Output 1

      6 2 2

      In the first query, 1 is inserted to S, making S=\lbrace 1\rbrace. Then, |S|=1 is added to A_1. The sequence becomes A=(1,0,0).
      In the second query, 3 is inserted to S, making S=\lbrace 1,3\rbrace. Then, |S|=2 is added to A_1 and A_3. The sequence becomes A=(3,0,2).
      In the third query, 3 is removed from S, making S=\lbrace 1\rbrace. Then, |S|=1 is added to A_1. The sequence becomes A=(4,0,2).
      In the fourth query, 2 is inserted to S, making S=\lbrace 1,2\rbrace. Then, |S|=2 is added to A_1 and A_2. The sequence becomes A=(6,2,2).
      Eventually, the sequence becomes A=(6,2,2).

      Sample Input 2

      4 6
      1 2 3 2 4 2

      Sample Output 2

      15 9 12 7

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 4\n1 3 3 2\n",
              "6 2 2\n"
          ],
          [
              "4 6\n1 2 3 2 4 2\n",
              "15 9 12 7\n"
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
