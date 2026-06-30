Feature: LiveCodeBench/atcoder/hard — Add and Multiply Queries
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given sequences of positive integers A and B of length N. Process Q queries given in the following forms in the order they are given. Each query is of one of the following three types.

      - 
      Type 1: Given in the form 1 i x. Replace A_i with x.

      - 
      Type 2: Given in the form 2 i x. Replace B_i with x.

      - 
      Type 3: Given in the form 3 l r. Solve the following problem and print the answer.

      - 
      Initially, set v = 0. For i = l, l+1, ..., r in this order, replace v with either v + A_i or v \times B_i. Find the maximum possible value of v at the end.




      It is guaranteed that the answers to the given type 3 queries are at most 10^{18}.

      Input

      The input is given from Standard Input in the following format:
      N
      A_1 A_2 \cdots A_N
      B_1 B_2 \cdots B_N
      Q
      query_1
      query_2
      \vdots
      query_Q

      Here, query_i is the i-th query, given in one of the following formats:
      1 i x

      2 i x

      3 l r

      Output

      Let q be the number of type 3 queries. Print q lines. The i-th line should contain the answer to the i-th type 3 query.

      Constraints


      - 1 \leq N \leq 10^5
      - 1 \leq A_i \leq 10^9
      - 1 \leq B_i \leq 10^9
      - 1 \leq Q \leq 10^5
      - For type 1 and 2 queries, 1 \leq i \leq N.
      - For type 1 and 2 queries, 1 \leq x \leq 10^9.
      - For type 3 queries, 1 \leq l \leq r \leq N.
      - For type 3 queries, the value to be printed is at most 10^{18}.

      Sample Input 1

      3
      3 2 4
      1 2 2
      3
      3 1 3
      1 1 1
      3 1 3

      Sample Output 1

      12
      7

      For the first query, the answer is ((0 + A_1) \times B_2) \times B_3 = 12.
      For the third query, the answer is ((0 + A_1) + A_2) + A_3 = 7.

      Sample Input 2

      6
      65 32 12 5 8 312
      4 1 3 15 16 2
      6
      3 2 6
      3 1 5
      1 5 6
      2 4 9
      3 2 6
      3 3 5

      Sample Output 2

      46080
      69840
      27648
      1728

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n3 2 4\n1 2 2\n3\n3 1 3\n1 1 1\n3 1 3\n",
              "12\n7\n"
          ],
          [
              "6\n65 32 12 5 8 312\n4 1 3 15 16 2\n6\n3 2 6\n3 1 5\n1 5 6\n2 4 9\n3 2 6\n3 3 5\n",
              "46080\n69840\n27648\n1728\n"
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
