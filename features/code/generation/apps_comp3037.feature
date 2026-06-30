Feature: APPS/competition/3037 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Mr. Turtle loves drawing on his whiteboard at home. One day when he was drawing, his marker dried out! Mr. Turtle then noticed that the marker behaved like an eraser for the remainder of his drawing.

      Mr. Turtle has a picture in his head of how he wants his final drawing to appear. He plans out his entire drawing ahead of time, step by step. Mr. Turtle’s plan is a sequence of commands: up, down, left or right, with a distance. He starts drawing in the bottom left corner of his whiteboard. Consider the $6 \times 8$ whiteboard and sequence of commands in the first diagram. If the marker runs dry at timestep $17$, the board will look like the second diagram (the numbers indicate the timestep when the marker is at each cell). Note that it will make a mark at timestep $17$, but not at timestep $18$. 

      Mr. Turtle wants to know the earliest and latest time his marker can dry out, and he’ll still obtain the drawing in his head. Can you help him? Note that timestep $0$ is the moment before the marker touches the board. It is valid for a marker to dry out at timestep $0$.

      -----Input-----
      Each input will consist of a single test case. Note that your program may be run multiple times on different inputs. The input will start with a line with $3$ space-separated integers $h$, $w$ and $n$ ($1 \le h,w,n \le 1000000, w \cdot h \le 1000000$) where $h$ and $w$ are the height and width of the whiteboard respectively, and $n$ is the number of commands in Mr. Turtle’s plan.

      The next $h$ lines will each consist of exactly $w$ characters, with each character being either ‘#’ or ‘.’ . This is the pattern in Mr. Turtle’s head, where ’#’ is a marked cell, and ‘.’ is a blank cell.

      The next $n$ lines will each consist of a command, of the form “direction distance”, with a single space between the direction and the distance and no other spaces on the line. The direction will be exactly one of the set $\{ \texttt{up}, \texttt{down}, \texttt{left}, \texttt{right} \} $, guaranteed to be all low
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
              "6 8 5\n........\n...#....\n########\n#..#...#\n#..#####\n#.......\nup 3\nright 7\ndown 2\nleft 4\nup 3\n",
              "20 20\n"
          ],
          [
              "6 8 5\n........\n........\n###.####\n#......#\n#..#####\n#.......\nup 3\nright 7\ndown 2\nleft 4\nup 3\n",
              "17 17\n"
          ],
          [
              "3 3 2\n...\n.#.\n...\nup 2\nright 2\n",
              "-1 -1\n"
          ],
          [
              "2 2 4\n..\n..\nup 1\nright 1\ndown 1\nleft 1\n",
              "0 1\n"
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
