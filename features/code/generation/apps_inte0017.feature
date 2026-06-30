Feature: APPS/interview/17 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Arpa is researching the Mexican wave.

      There are n spectators in the stadium, labeled from 1 to n. They start the Mexican wave at time 0. 

        At time 1, the first spectator stands.  At time 2, the second spectator stands.  ...  At time k, the k-th spectator stands.  At time k + 1, the (k + 1)-th spectator stands and the first spectator sits.  At time k + 2, the (k + 2)-th spectator stands and the second spectator sits.  ...  At time n, the n-th spectator stands and the (n - k)-th spectator sits.  At time n + 1, the (n + 1 - k)-th spectator sits.  ...  At time n + k, the n-th spectator sits. 

      Arpa wants to know how many spectators are standing at time t.


      -----Input-----

      The first line contains three integers n, k, t (1 ≤ n ≤ 10^9, 1 ≤ k ≤ n, 1 ≤ t < n + k).


      -----Output-----

      Print single integer: how many spectators are standing at time t.


      -----Examples-----
      Input
      10 5 3

      Output
      3

      Input
      10 5 7

      Output
      5

      Input
      10 5 12

      Output
      3



      -----Note-----

      In the following a sitting spectator is represented as -, a standing spectator is represented as ^.

        At t = 0  ---------- $\Rightarrow$ number of standing spectators = 0.  At t = 1  ^--------- $\Rightarrow$ number of standing spectators = 1.  At t = 2  ^^-------- $\Rightarrow$ number of standing spectators = 2.  At t = 3  ^^^------- $\Rightarrow$ number of standing spectators = 3.  At t = 4  ^^^^------ $\Rightarrow$ number of standing spectators = 4.  At t = 5  ^^^^^----- $\Rightarrow$ number of standing spectators = 5.  At t = 6  -^^^^^---- $\Rightarrow$ number of standing spectators = 5.  At t = 7  --^^^^^--- $\Rightarrow$ number of standing spectators = 5.  At t = 8  ---^^^^^-- $\Rightarrow$ number of standing spectators = 5.  At t = 9  ----^^^^^- $\Rightarrow$ number of standing spectators = 5.  At t = 10 -----^^^^^ $\Rightarrow$ number of standing spectators = 5.  At t = 11 ------^^^^ $\Rightarrow$ number of standing spectators = 4.  At t = 12 -------^^^ $\Rightarrow$ number of standing spectators = 3.  At t 
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
              "10 5 3\n",
              "3\n"
          ],
          [
              "10 5 7\n",
              "5\n"
          ],
          [
              "10 5 12\n",
              "3\n"
          ],
          [
              "840585600 770678331 788528791\n",
              "770678331\n"
          ],
          [
              "25462281 23343504 8024619\n",
              "8024619\n"
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
