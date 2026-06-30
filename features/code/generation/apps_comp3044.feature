Feature: APPS/competition/3044 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Your friend just bought a new programmable robot and has asked for your help. The robot operates in a 2D grid that may contain obstacles. The environment has a known start location and a known goal location. The robot is controlled with a string consisting of commands L, R, U, and D, which respectively instruct the robot to move one square to the left, right, up or down in the grid. The robot will ignore a command (but continue with future commands) if the command would cause it to leave the grid or to run into an obstacle. If the robot were to reach the goal position, it immediately stops its program with success (even if further commands exist).

      Your friend has already programmed the robot with a command string, but the problem is that your friend is not a very good programmer, and so it may be that the commands do not lead the robot successfully to the goal. You would like to fix the string so that the robot will reach the goal, but you do not want your friend to feel bad, so you are hoping to make as few changes to the program as are needed. A single change consists either of deleting an arbitrary character of the command string, or inserting an arbitrary command anywhere within the string.

      As an example, if we consider Sample Input 1, we see that your friend’s command string of DRRDD does not succeed. The initial D moves the robot one spot down. From there, the R (and the subsequent R) are ignored because of the obstacle to the robot’s right. The subsequent D moves the robot down once again and the final D is ignored. However, by deleting the initial D, we can rely on the command string RRDD which does successfully lead the robot to the goal.

      If we consider Sample Input 2, we find that your friend’s original command string LDLDLLDR is flawed. However, if we insert the single command U after the fifth command, the resulting string LDLDLULDR successfully guides the robot to the goal. It starts by moving left-down-left; the next down command is ignored because 
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
              "3 3\nS..\n.#.\n..G\nDRRDD\n",
              "1\n"
          ],
          [
              "3 7\n.......\n.G.#.S.\n.......\nLDLDLLDR\n",
              "1\n"
          ],
          [
              "3 7\n.#.....\n.G.##S.\n.......\nLDLDLLDR\n",
              "2\n"
          ],
          [
              "2 4\nS.#.\n#..G\nRRUUDDRRUUUU\n",
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
