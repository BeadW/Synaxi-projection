Feature: APPS/competition/3046 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      In the recently proposed Visual Python++ programming language, a block of statements is represented as a rectangle of characters with top-left corner in row $r_1$ and column $c_1$, and bottom-right corner in row $r_2$ and column $c_2$. All characters at locations $(r, c)$ with $r_1 \leq r \leq r_2$ and $c_1 \leq c \leq c_2$ are then considered to belong to that block. Among these locations, the ones with $r = r_1$ or $r = r_2$ or $c = c_1$ or $c = c_2$ are called a border.

      Statement blocks can be nested (rectangles contained in other rectangles) to an arbitrary level. In a syntactically correct program, every two statement blocks are either nested (one contained in the other) or disjoint (not overlapping). In both cases, their borders may not overlap.

      Programmers are not expected to draw the many rectangles contained in a typical program – this takes too long, and Visual Python++ would not have a chance to become the next ICPC programming language. So a programmer only has to put one character ‘$\ulcorner $’ in the top-left corner of the rectangle and one character ‘$\lrcorner $’ in the bottom-right corner. The parser will automatically match up the appropriate corners to obtain the nesting structure of the program.

      Your team has just been awarded a five-hour contract to develop this part of the parser.

      -----Input-----
      The first line of the input contains an integer $n$ ($1 \leq n \leq 10^5$), the number of corner pairs. Each of the next $n$ lines contains two integers $r$ and $c$ ($1 \leq r, c \leq 10^9$), specifying that there is a top-left corner in row $r$ and column $c$ of the program you are parsing. Following that are $n$ lines specifying the bottom-right corners in the same way. All corner locations are distinct.

      -----Output-----
      Display $n$ lines, each containing one integer. A number $j$ in line $i$ means that the $i^{\text {th}}$ top-left corner and the $j^{\text {th}}$ bottom-right corner form one rectangle. Top-left and bottom-right corners are eac
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
              "2\n4 7\n9 8\n14 17\n19 18\n",
              "2\n1\n"
          ],
          [
              "2\n4 7\n14 17\n9 8\n19 18\n",
              "1\n2\n"
          ],
          [
              "2\n4 8\n9 7\n14 18\n19 17\n",
              "syntax error\n"
          ],
          [
              "3\n1 1\n4 8\n8 4\n10 6\n6 10\n10 10\n",
              "syntax error\n"
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
