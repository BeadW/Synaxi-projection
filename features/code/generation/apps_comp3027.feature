Feature: APPS/competition/3027 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Bureaucrats love bureaucracy. This assertion seems fairly obvious but a less obvious observation is the amount of paperwork this means!

      When paperwork is complete, a bureaucrat stamps the official document with their official stamp of office. Some bureaucrats are extra thorough and stamp the document multiple times. We are interested primarily in bureaucrats that stamp their documents exactly twice.

      A bureaucrat stamp takes up some rectangular area. For example, the below is a bureaucrat stamp:

             ..#..#.. .######. ..#..#..

      When the bureaucrat stamps the paper twice it is potentially moved to a different location on the paper, but it is not rotated. The stamp will always be axis aligned. The ’#’ symbol on a stamp covers the paper with black ink at the cell on the paper that is pressed. A ’.’ doesn’t leave any marks on the paper nor does it remove a mark. If a cell of the paper is marked twice it is not discernable from a cell that is marked once.

      You will be given a mark on a paper that was stamped twice by a stamp. Your task is to determine the minimum number of nubs (’#’ symbols) that could have possibly been on the original stamp. The paper is guaranteed to be stamped twice by the entire stamp. (All of the stamp will be on the paper in both stampings)

      Consider the following mark on paper:

             ..#..#.. .######. .######. ..#..#..

      It could have been made with the first stamp example, with the second stamping exactly one cell below the first. Or, it could have been made with a stamp that looks like this, stamped side-by-side:

             ..#.. .###. .###. ..#..

      In this case, 8 would be the correct answer.

      -----Input-----
      Each input will consist of a single test case. Note that your program may be run multiple times on different inputs. Each test case will begin with a line with two integers, $n$ and $m$ ($1 \le n, m \le 500$) indicating the height and width of the mark on the paper. Each of the next $n$ lines will have exactly $m$ characters, consisting 
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
              "4 8\n..#..#..\n.######.\n.######.\n..#..#..\n",
              "8\n"
          ],
          [
              "3 3\n...\n.#.\n...\n",
              "1\n"
          ],
          [
              "2 6\n.#####\n#####.\n",
              "5\n"
          ],
          [
              "2 5\n.#.#.\n#.#.#\n",
              "3\n"
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
