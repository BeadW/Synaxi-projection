Feature: LiveCodeBench/atcoder/medium — T
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      AtCoder Inc. sells T-shirts with its logo.
      You are given Takahashi's schedule for N days as a string S of length N consisting of 0, 1, and 2.
      Specifically, for an integer i satisfying 1\leq i\leq N,

      - if the i-th character of S is 0, he has no plan scheduled for the i-th day;
      - if the i-th character of S is 1, he plans to go out for a meal on the i-th day;
      - if the i-th character of S is 2, he plans to attend a competitive programming event on the i-th day.

      Takahashi has M plain T-shirts, all washed and ready to wear just before the first day.
      In addition, to be able to satisfy the following conditions, he will buy several AtCoder logo T-shirts.

      - On days he goes out for a meal, he will wear a plain or logo T-shirt.
      - On days he attends a competitive programming event, he will wear a logo T-shirt.
      - On days with no plans, he will not wear any T-shirts. Also, he will wash all T-shirts worn at that point. He can wear them again from the next day onwards.
      - Once he wears a T-shirt, he cannot wear it again until he washes it.

      Determine the minimum number of T-shirts he needs to buy to be able to wear appropriate T-shirts on all scheduled days during the N days. If he does not need to buy new T-shirts, print 0.
      Assume that the purchased T-shirts are also washed and ready to use just before the first day.

      Input

      The input is given from Standard Input in the following format:
      N M
      S

      Output

      Print the minimum number of T-shirts Takahashi needs to buy to be able to satisfy the conditions in the problem statement.
      If he does not need to buy new T-shirts, print 0.

      Constraints


      - 1\leq M\leq N\leq 1000
      - S is a string of length N consisting of 0, 1, and 2.
      - N and M are integers.

      Sample Input 1

      6 1
      112022

      Sample Output 1

      2

      If Takahashi buys two logo T-shirts, he can wear T-shirts as follows:

      - On the first day, he wears a logo T-shirt to go out for a meal.
      - On the second day, he wears a plain T-shirt to go out for a meal.
      - On the third day, he wears a logo T-shir

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "6 1\n112022\n",
              "2\n"
          ],
          [
              "3 1\n222\n",
              "3\n"
          ],
          [
              "2 1\n01\n",
              "0\n"
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
