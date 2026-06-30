Feature: APPS/competition/3023 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      On his birthday, John’s parents made him a huge birthday cake! Everyone had a wonderful dinner, and now it’s time to eat the cake. There are $n$ candles on the cake. John wants to divide the cake into $n$ pieces so that each piece has exactly one candle on it, and there are no left-over pieces. For that, he made $m$ cuts across the cake. Could you help check if John’s cuts successfully divide the candles on the cake?

      Formally, the cake is a circle of radius $r$ centered at $(0, 0)$. The candles are $n$ distinct points located strictly inside the circle. Each cut is a straight line $ax + by + c = 0$, described by three coefficients $a$, $b$, and $c$.

      -----Input-----
      Input starts with three integers $n$ ($1 \leq n \leq 50$), $m$ ($1 \leq m \leq 15$), and $r$ ($1 \leq r \leq 100$) on the first line.

      The next $n$ lines give the locations of the candles. Each line has two integers $x$ and $y$ giving the coordinates of one candle ($0 \leq \sqrt {x^2 + y^2} < r$).

      The next $m$ lines give the coefficients of the cutting lines. Each line has three integers $a$, $b$, and $c$ ($0 \leq |a|, |b| \leq 100, 0 \leq |c| \leq 20000$) describing a line of the form $ax + by + c = 0$. The values $a$ and $b$ are not both zero.

      All candles and lines are distinct. No candle is on a cut line. No line is completely outside or tangent to the cake. The input guarantees that the number of cake pieces remains the same if any cut line is shifted by at most $10^{-4}$ in any direction. The input also guarantees that each candle remains in the interior of the same piece of cake if its position is shifted by at most $10^{-4}$ in any direction.

      -----Output-----
      Output “yes” if John’s cuts successfully divide the cake so that each piece he obtains has exactly one candle on it. Otherwise, output “no”.

      -----Examples-----
      Sample Input 1:
      4 2 3
      0 1
      1 0
      -1 0
      0 -1
      -1 1 0
      2 1 0
      Sample Output 1:
      yes

      Sample Input 2:
      4 3 3
      0 1
      1 2
      -1 2
      0 -1
      -1 1 -2
      -1 -1 2
      0 -1 0
      Sample Output 2:
      no

      Sample Input 3:
      3 2 
      ...(truncated)

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "4 2 3\n0 1\n1 0\n-1 0\n0 -1\n-1 1 0\n2 1 0\n",
              "yes\n"
          ],
          [
              "4 3 3\n0 1\n1 2\n-1 2\n0 -1\n-1 1 -2\n-1 -1 2\n0 -1 0\n",
              "no\n"
          ],
          [
              "3 2 3\n2 1\n0 0\n-1 -2\n1 1 -2\n3 6 12\n",
              "yes\n"
          ],
          [
              "3 1 2\n0 0\n-1 1\n1 -1\n-2 2 1\n",
              "no\n"
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
