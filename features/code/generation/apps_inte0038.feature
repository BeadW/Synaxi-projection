Feature: APPS/interview/38 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Running with barriers on the circle track is very popular in the country where Dasha lives, so no wonder that on her way to classes she saw the following situation:

      The track is the circle with length L, in distinct points of which there are n barriers. Athlete always run the track in counterclockwise direction if you look on him from above. All barriers are located at integer distance from each other along the track. 

      Her friends the parrot Kefa and the leopard Sasha participated in competitions and each of them ran one lap. Each of the friends started from some integral point on the track. Both friends wrote the distance from their start along the track to each of the n barriers. Thus, each of them wrote n integers in the ascending order, each of them was between 0 and L - 1, inclusively. [Image] Consider an example. Let L = 8, blue points are barriers, and green points are Kefa's start (A) and Sasha's start (B). Then Kefa writes down the sequence [2, 4, 6], and Sasha writes down [1, 5, 7]. 

      There are several tracks in the country, all of them have same length and same number of barriers, but the positions of the barriers can differ among different tracks. Now Dasha is interested if it is possible that Kefa and Sasha ran the same track or they participated on different tracks. 

      Write the program which will check that Kefa's and Sasha's tracks coincide (it means that one can be obtained from the other by changing the start position). Note that they always run the track in one direction — counterclockwise, if you look on a track from above. 


      -----Input-----

      The first line contains two integers n and L (1 ≤ n ≤ 50, n ≤ L ≤ 100) — the number of barriers on a track and its length. 

      The second line contains n distinct integers in the ascending order — the distance from Kefa's start to each barrier in the order of its appearance. All integers are in the range from 0 to L - 1 inclusively.

      The second line contains n distinct integers in the ascending order — the d
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
              "3 8\n2 4 6\n1 5 7\n",
              "YES\n"
          ],
          [
              "4 9\n2 3 5 8\n0 1 3 6\n",
              "YES\n"
          ],
          [
              "2 4\n1 3\n1 2\n",
              "NO\n"
          ],
          [
              "5 9\n0 2 5 6 7\n1 3 6 7 8\n",
              "YES\n"
          ],
          [
              "5 60\n7 26 27 40 59\n14 22 41 42 55\n",
              "YES\n"
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
