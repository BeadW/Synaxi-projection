Feature: LiveCodeBench/atcoder/hard — Random Swaps of Balls
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There are N - 1 white balls and one black ball. These N balls are arranged in a row, with the black ball initially at the leftmost position.
      Takahashi will perform the following operation exactly K times.

      - Choose an integer uniformly at random between 1 and N, inclusive, twice. Let a and b the chosen integers. If a \neq b, swap the a-th and b-th balls from the left.

      After K operations, let the black ball be at the x-th position from the left. Find the expected value of x, modulo 998244353.


      What is expected value modulo 998244353?

      It can be proved that the sought expected value will always be rational. Additionally, under the constraints of this problem, it can be proved that if this value is expressed as an irreducible fraction \frac{P}{Q}, then Q \not \equiv 0 \pmod{998244353}. Therefore, there exists a unique integer R such that R \times Q \equiv P \pmod{998244353}, 0 \leq R < 998244353. Report this R.

      Input

      The input is given from Standard Input in the following format:
      N K

      Output

      Print the answer in one line.

      Constraints


      - 1 \leq N \leq 998244352
      - 1 \leq K \leq 10^5

      Sample Input 1

      2 1

      Sample Output 1

      499122178

      After one operation, the probabilities that the black ball is at the 1st position and the 2nd position from the left are both \displaystyle \frac{1}{2}. Thus, the expected value is \displaystyle \frac{3}{2}.

      Sample Input 2

      3 2

      Sample Output 2

      554580198

      Sample Input 3

      4 4

      Sample Output 3

      592707587

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "2 1\n",
              "499122178\n"
          ],
          [
              "3 2\n",
              "554580198\n"
          ],
          [
              "4 4\n",
              "592707587\n"
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
