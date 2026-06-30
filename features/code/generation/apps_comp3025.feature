Feature: APPS/competition/3025 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      In the hills of a distant land there is a valley with many villages. The villages are all ruled by a cruel king who demands that each village pay him tribute in gold each year. The villages are required to bring gold to the king as quickly as possible when he demands it.

      There is a bandit village in the kingdom. The bandit village has saved no gold for the king, because they spent every bit of gold that they had! What are they going to do? Well, since they’re bandits, when they travel through other villages to get to the castle, they may (or may not) choose to steal the gold from any of those villages on their path to the castle, and present it to the king as their own.

      The bandits travel through as few villages as possible to reach the castle. They also have one other consideration-after delivering the gold to the king the bandits must be able to return home. They consider it unsafe to return home traveling through a village from whom they stole gold. The bandits do not otherwise care how long it takes to return home.

      Determine the maximum amount of gold the bandits can steal on their way to the king’s castle and still be able to return home safely.

      -----Input-----
      There will be a single test case in the input. This test case will begin with a line with two integers, $n$ ($3 \le n \le 36$) and $m$ ($n-1 \le m \le n(n-1)/2$), where $n$ is the number of villages, and $m$ is the number of roads. The villages are numbered $1 \ldots n$. Village $1$ is the bandit’s home, and village $2$ holds the king’s castle. On the next line will be $n-2$ space-separated integers $g$ ($1 \le g \le 5000$), which are the amount of gold in each village $3, 4, \ldots , n$, skipping the bandit’s home and the king’s castle. On each of the following $m$ lines will be two integers, $a$ and $b$ ($1 \le a < b \le n$) indicating that there is a road between villages $a$ and $b$. All roads are two-way. All $m$ $(a,b)$ pairs will be unique. There will be a path, direct or indirect, from every 
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
              "3 3\n1\n1 2\n2 3\n1 3\n",
              "0\n"
          ],
          [
              "4 4\n24 10\n1 3\n2 3\n2 4\n1 4\n",
              "24\n"
          ],
          [
              "6 8\n100 500 300 75\n1 3\n1 4\n3 6\n4 5\n3 5\n4 6\n2 5\n2 6\n",
              "800\n"
          ],
          [
              "7 7\n90 1000 700 2000 800\n1 3\n1 4\n1 5\n3 7\n5 6\n2 6\n3 6\n",
              "700\n"
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
