Feature: APPS/interview/30 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      The campus has $m$ rooms numbered from $0$ to $m - 1$. Also the $x$-mouse lives in the campus. The $x$-mouse is not just a mouse: each second $x$-mouse moves from room $i$ to the room $i \cdot x \mod{m}$ (in fact, it teleports from one room to another since it doesn't visit any intermediate room). Starting position of the $x$-mouse is unknown.

      You are responsible to catch the $x$-mouse in the campus, so you are guessing about minimum possible number of traps (one trap in one room) you need to place. You are sure that if the $x$-mouse enters a trapped room, it immediately gets caught.

      And the only observation you made is $\text{GCD} (x, m) = 1$.


      -----Input-----

      The only line contains two integers $m$ and $x$ ($2 \le m \le 10^{14}$, $1 \le x < m$, $\text{GCD} (x, m) = 1$) — the number of rooms and the parameter of $x$-mouse. 


      -----Output-----

      Print the only integer — minimum number of traps you need to install to catch the $x$-mouse.


      -----Examples-----
      Input
      4 3

      Output
      3

      Input
      5 2

      Output
      2



      -----Note-----

      In the first example you can, for example, put traps in rooms $0$, $2$, $3$. If the $x$-mouse starts in one of this rooms it will be caught immediately. If $x$-mouse starts in the $1$-st rooms then it will move to the room $3$, where it will be caught.

      In the second example you can put one trap in room $0$ and one trap in any other room since $x$-mouse will visit all rooms $1..m-1$ if it will start in any of these rooms.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "4 3\n",
              "3\n"
          ],
          [
              "5 2\n",
              "2\n"
          ],
          [
              "7 2\n",
              "3\n"
          ],
          [
              "2 1\n",
              "2\n"
          ],
          [
              "100000000000000 1\n",
              "100000000000000\n"
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
