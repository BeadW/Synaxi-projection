Feature: APPS/competition/3016 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Baby Timmy has a pool of balls that he plays with. The pool is made up of balls with $n$ different colors with a certain number of each color. Baby Timmy finds it interesting to order these balls in a line given certain conditions he made. Timmy has two conditions when playing his own game:
       - Balls of certain colors may not be next to each other
       - One particular sequence of colors which Timmy likes most must appear as many times as possible

      Can you compute the total number of different ways in which Timmy can arrange his balls?

      For instance, suppose Timmy has $2$ red, $1$ yellow, $2$ green, and $1$ blue ball(s). He doesn’t like for red or yellow balls to be next to each other, and his favorite sequence is “green blue.” The following six arrangements meet the requirements:

      red green blue red green yellow 
      red green blue yellow green red 
      red green red green blue yellow 
      red green yellow green blue red 
      yellow green blue red green red 
      yellow green red green blue red 

      This arrangement corresponds to Sample Input 1.

      Note that Timmy insists on including his favorite sequence as often as the available balls allow, even if that means not being able to complete the arrangement of balls at all.

      -----Input-----
      The input consists of a single test case with three lines. The first line contains an integer $n$ ($2 \le n \le 50$), which describe the number of different colors. The remaining $n$ integers on that line denote how many balls Timmy has of each color (colors are numbered $1$ through $n$ and their frequencies appear in order). The number of balls he has of each color is between $1$ and $50$, inclusive.

      The second line of input describes which colors Timmy does not want next to each other. The first integer $k$ ($0 \le k \le n$) gives the number of colors. This is followed by $k$ integers $c_ i$ ($1 \le c_ i \le n$) denoting the colors that prevent balls having any of these colors from being next to each other. Each $c_ i$ is unique.

      The third line of input de
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
              "4 2 1 2 1\n2 1 2\n2 3 4\n",
              "6\n"
          ],
          [
              "3 3 1 1\n1 1\n2 2 3\n",
              "0\n"
          ],
          [
              "3 2 2 3\n1 1\n2 2 3\n",
              "18\n"
          ],
          [
              "3 1 2 3\n2 1 2\n0\n",
              "12\n"
          ],
          [
              "3 1 4 1\n1 2\n1 3\n",
              "0\n"
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
