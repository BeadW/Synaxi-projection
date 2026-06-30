Feature: APPS/interview/19 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Polycarp has recently created a new level in this cool new game Berlio Maker 85 and uploaded it online. Now players from all over the world can try his level.

      All levels in this game have two stats to them: the number of plays and the number of clears. So when a player attempts the level, the number of plays increases by $1$. If he manages to finish the level successfully then the number of clears increases by $1$ as well. Note that both of the statistics update at the same time (so if the player finishes the level successfully then the number of plays will increase at the same time as the number of clears).

      Polycarp is very excited about his level, so he keeps peeking at the stats to know how hard his level turns out to be.

      So he peeked at the stats $n$ times and wrote down $n$ pairs of integers — $(p_1, c_1), (p_2, c_2), \dots, (p_n, c_n)$, where $p_i$ is the number of plays at the $i$-th moment of time and $c_i$ is the number of clears at the same moment of time. The stats are given in chronological order (i.e. the order of given pairs is exactly the same as Polycarp has written down).

      Between two consecutive moments of time Polycarp peeked at the stats many players (but possibly zero) could attempt the level.

      Finally, Polycarp wonders if he hasn't messed up any records and all the pairs are correct. If there could exist such a sequence of plays (and clears, respectively) that the stats were exactly as Polycarp has written down, then he considers his records correct.

      Help him to check the correctness of his records.

      For your convenience you have to answer multiple independent test cases.


      -----Input-----

      The first line contains a single integer $T$ $(1 \le T \le 500)$ — the number of test cases.

      The first line of each test case contains a single integer $n$ ($1 \le n \le 100$) — the number of moments of time Polycarp peeked at the stats.

      Each of the next $n$ lines contains two integers $p_i$ and $c_i$ ($0 \le p_i, c_i \le 1000$) — the number of plays a
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
              "6\n3\n0 0\n1 1\n1 2\n2\n1 0\n1000 3\n4\n10 1\n15 2\n10 2\n15 2\n1\n765 432\n2\n4 4\n4 3\n5\n0 0\n1 0\n1 0\n1 0\n1 0\n",
              "NO\nYES\nNO\nYES\nNO\nYES\n"
          ],
          [
              "1\n2\n10 1\n11 3\n",
              "NO\n"
          ],
          [
              "1\n2\n5 2\n8 6\n",
              "NO\n"
          ],
          [
              "1\n2\n43 34\n44 35\n",
              "YES\n"
          ],
          [
              "1\n2\n4 1\n5 3\n",
              "NO\n"
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
