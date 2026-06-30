Feature: APPS/competition/3019 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Today everyone is talking about big data. As a renowned data provider in the area, you now have $N$ precious pieces of data. You want to sell all $N$ pieces of data to $N$ customers. You can sell multiple pieces of data (including all and none) to a single customer. However, each piece of data must be sold to exactly one customer (you cannot split a single piece of data and sell it to multiple customers).

      In your previous transactions you simply sold bigger data for higher prices. Unfortunately, that did not work quite well and your customers were a bit unsatisfied about the value of the data they got. Obviously, the value of data is not necessarily positively correlated with its volume.

      This time you decide to do something different. After many meetings you finally sign a new contract with your customers. You number the $N$ pieces of data from $1$ to $N$ and figure out that the $i^\textrm {th}$ piece of data has a special property $S_ i$. The new contract specifies that each customer shall pay you an amount of money that is equal to the number of distinct prime factors in the sum of $S_ i$’s of the data pieces sold to him/her.

      Based on the new contract, what is the maximum revenue you can achieve by selling all $N$ pieces of data?

      -----Input-----
      The first line has a single integer $N$ ($1 \leq N \leq 14$). The second line has $N$ positive integers, $S_1, S_2, \ldots , S_ N$. These integers are no larger than $1000$.

      -----Output-----
      Output the maximum revenue you can achieve by selling all $N$ pieces of data.

      -----Examples-----
      Sample Input 1:
      1
      1
      Sample Output 1:
      0

      Sample Input 2:
      3
      4 7 8
      Sample Output 2:
      3

      Sample Input 3:
      5
      2 3 4 5 8
      Sample Output 3:
      5

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "1\n1\n",
              "0\n"
          ],
          [
              "3\n4 7 8\n",
              "3\n"
          ],
          [
              "5\n2 3 4 5 8\n",
              "5\n"
          ],
          [
              "10\n1 2 3 4 5 6 7 8 9 10\n",
              "12\n"
          ]
      ]


      def test_apps():
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

  Scenario: Agent solves the APPS problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py to read from stdin and write the correct answer to stdout so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
