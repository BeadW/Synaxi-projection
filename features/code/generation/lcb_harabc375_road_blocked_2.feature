Feature: LiveCodeBench/atcoder/hard — Road Blocked 2
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      In the nation of AtCoder, there are N cities numbered 1 to N, and M roads numbered 1 to M.
      Road i connects cities A_i and B_i bidirectionally and has a length of C_i.
      For each i = 1, \ldots, M, determine whether the following two values are different.

      - The shortest distance from city 1 to city N when all roads are passable
      - The shortest distance from city 1 to city N when the M - 1 roads other than road i are passable

      If city N can be reached from city 1 in one of these cases but not the other, the two values are considered different.

      Input

      The input is given from Standard Input in the following format:
      N M
      A_1 B_1 C_1
      \vdots
      A_M B_M C_M

      Output

      Print M lines. The i-th line should contain Yes if the shortest distance from city 1 to city N when all roads are passable is different from the shortest distance when the M - 1 roads other than road i are passable, and No otherwise.
      If city N can be reached from city 1 in one of these cases but not the other, the two values are considered different.

      Constraints


      - 2 \leq N \leq 2 \times 10^5
      - 1 \leq M \leq 2 \times 10^5
      - 1 \leq A_i < B_i \leq N
      - All pairs (A_i, B_i) are distinct.
      - 1 \leq C_i \leq 10^9
      - City N can be reached from city 1 when all roads are passable.
      - All input values are integers.

      Sample Input 1

      3 3
      1 2 5
      1 3 10
      2 3 6

      Sample Output 1

      No
      Yes
      No

      When all roads are passable, the shortest distance from city 1 to city 3 is 10.

      - When the two roads other than road 1 are passable, the shortest distance is 10.
      - When the two roads other than road 2 are passable, the shortest distance is 11.
      - When the two roads other than road 3 are passable, the shortest distance is 10.

      Sample Input 2

      4 6
      2 3 1
      2 4 1
      3 4 1
      1 2 1
      1 3 1
      1 4 1

      Sample Output 2

      No
      No
      No
      No
      No
      Yes

      When all roads are passable, the shortest distance from city 1 to city 4 is 1.
      When the five roads other than road 6 are passable, the shortest distance is 2.

      Sample Input 3

      2 1
      1 2 1

      Sample Output 3

      Yes

      Whe

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 3\n1 2 5\n1 3 10\n2 3 6\n",
              "No\nYes\nNo\n"
          ],
          [
              "4 6\n2 3 1\n2 4 1\n3 4 1\n1 2 1\n1 3 1\n1 4 1\n",
              "No\nNo\nNo\nNo\nNo\nYes\n"
          ],
          [
              "2 1\n1 2 1\n",
              "Yes\n"
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
