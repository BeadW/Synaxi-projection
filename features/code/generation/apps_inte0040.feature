Feature: APPS/interview/40 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Is it rated?

      Here it is. The Ultimate Question of Competitive Programming, Codeforces, and Everything. And you are here to answer it.

      Another Codeforces round has been conducted. No two participants have the same number of points. For each participant, from the top to the bottom of the standings, their rating before and after the round is known.

      It's known that if at least one participant's rating has changed, then the round was rated for sure.

      It's also known that if the round was rated and a participant with lower rating took a better place in the standings than a participant with higher rating, then at least one round participant's rating has changed.

      In this problem, you should not make any other assumptions about the rating system.

      Determine if the current round is rated, unrated, or it's impossible to determine whether it is rated of not.


      -----Input-----

      The first line contains a single integer n (2 ≤ n ≤ 1000) — the number of round participants.

      Each of the next n lines contains two integers a_{i} and b_{i} (1 ≤ a_{i}, b_{i} ≤ 4126) — the rating of the i-th participant before and after the round, respectively. The participants are listed in order from the top to the bottom of the standings.


      -----Output-----

      If the round is rated for sure, print "rated". If the round is unrated for sure, print "unrated". If it's impossible to determine whether the round is rated or not, print "maybe".


      -----Examples-----
      Input
      6
      3060 3060
      2194 2194
      2876 2903
      2624 2624
      3007 2991
      2884 2884

      Output
      rated

      Input
      4
      1500 1500
      1300 1300
      1200 1200
      1400 1400

      Output
      unrated

      Input
      5
      3123 3123
      2777 2777
      2246 2246
      2246 2246
      1699 1699

      Output
      maybe



      -----Note-----

      In the first example, the ratings of the participants in the third and fifth places have changed, therefore, the round was rated.

      In the second example, no one's rating has changed, but the participant in the second place has lower rating than the participant in the fourth place. Therefore, if the round was rat
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
              "6\n3060 3060\n2194 2194\n2876 2903\n2624 2624\n3007 2991\n2884 2884\n",
              "rated\n"
          ],
          [
              "4\n1500 1500\n1300 1300\n1200 1200\n1400 1400\n",
              "unrated\n"
          ],
          [
              "5\n3123 3123\n2777 2777\n2246 2246\n2246 2246\n1699 1699\n",
              "maybe\n"
          ],
          [
              "2\n1 1\n1 1\n",
              "maybe\n"
          ],
          [
              "2\n4126 4126\n4126 4126\n",
              "maybe\n"
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
