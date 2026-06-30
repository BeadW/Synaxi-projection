Feature: LiveCodeBench/codeforces/medium — C. Raspberries
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an array of integers $a_1, a_2, \ldots, a_n$ and a number $k$ ($2 \leq k \leq 5$). In one operation, you can do the following:


      -  Choose an index $1 \leq i \leq n$,
      -  Set $a_i = a_i + 1$.Find the minimum number of operations needed to make the product of all the numbers in the array $a_1 \cdot a_2 \cdot \ldots \cdot a_n$ divisible by $k$.

      Input

      Each test consists of multiple test cases. The first line contains a single integer $t$ ($1 \leq t \leq 10^4$) — the number of test cases. Then follows the description of the test cases.

      The first line of each test case contains two integers $n$ and $k$ ($2 \leq n \leq 10^5$, $2 \leq k \leq 5$) — the size of the array $a$ and the number $k$.

      The second line of each test case contains $n$ integers $a_1, a_2, \ldots, a_n$ ($1 \leq a_i \leq 10$).

      It is guaranteed that the sum of $n$ over all test cases does not exceed $2 \cdot 10^5$.

      Output

      For each test case, output the minimum number of operations needed to make the product of all the numbers in the array divisible by $k$.Sample Input 1:
      15

      2 5

      7 3

      3 3

      7 4 1

      5 2

      9 7 7 3 9

      5 5

      5 4 1 2 3

      7 4

      9 5 1 5 9 5 1

      3 4

      6 3 6

      3 4

      6 1 5

      3 4

      1 5 9

      4 4

      1 4 1 1

      3 4

      3 5 3

      4 5

      8 9 9 3

      2 5

      1 6

      2 5

      10 10

      4 5

      1 6 1 1

      2 5

      7 7



      Sample Output 1:

      2
      2
      1
      0
      2
      0
      1
      2
      0
      1
      1
      4
      0
      4
      3


      Note

      In the first test case, we need to choose the index $i = 2$ twice. After that, the array will be $a = [7, 5]$. The product of all the numbers in the array is $35$.

      In the fourth test case, the product of the numbers in the array is $120$, which is already divisible by $5$, so no operations are needed.

      In the eighth test case, we can perform two operations by choosing $i = 2$ and $i = 3$ in any order. After that, the array will be $a = [1, 6, 10]$. The product of the numbers in the array is $60$.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "15\n2 5\n7 3\n3 3\n7 4 1\n5 2\n9 7 7 3 9\n5 5\n5 4 1 2 3\n7 4\n9 5 1 5 9 5 1\n3 4\n6 3 6\n3 4\n6 1 5\n3 4\n1 5 9\n4 4\n1 4 1 1\n3 4\n3 5 3\n4 5\n8 9 9 3\n2 5\n1 6\n2 5\n10 10\n4 5\n1 6 1 1\n2 5\n7 7\n",
              "2\n2\n1\n0\n2\n0\n1\n2\n0\n1\n1\n4\n0\n4\n3\n"
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
