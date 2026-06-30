Feature: APPS/competition/3007 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Trapped at home in quarantine, Johan tries to keep madness at bay and fend off isolation by playing Critter Junction, a social simulation video game. One of the main aspects of the game is collecting and harvesting various types of resources, in order to gain Bling, the currency of the game. Johan specializes in running the fruit% category of the game, in which the goal is to obtain the maximum amount of Bling in $40$ days using only fruits and no other resources. 

      Each fruit can be sold for $100$ Bling, or planted to become a fruit tree (but not both). Every three days, starting on the third day after it was planted, a fruit tree yields three new fruits.

      There are also some more exotic fruits that can be bought from the neighboring village. Once per day, the player can travel to the neighboring village and pay $400$ Bling to buy a single exotic fruit which you can then plant or sell already on the same day. Analogously to normal fruits, these exotic fruits can be planted into exotic fruit trees which yield three exotic fruits every three days. Each exotic fruit can be sold for $500$ Bling.

      Any number of fruits/exotic fruits can be harvested, sold and planted during a day (subject to availability of course, e.g. it is not possible to sell more fruits than you actually have), but at most a single exotic fruit can be bought. These activities can be done in any order, so it is for instance possible within the same day to first harvest a few fruits (exotic or not), then sell those fruits for Bling, then use that Bling to buy an exotic fruit, and then either plant or sell that exotic fruit.

      Given the current state of Johan’s fruit farm, what is the maximum amount of Bling he can achieve in the remaining time?

      -----Input-----
      The input consists of a single line containing six integers $d$, $b$, $f$, $t_0$, $t_1$ and $t_2$ ($1 \le d \le 40$, $0 \le b \le 500$, and $0 \le f, t_0, t_1, t_2 \le 100$), where:
       - $d$ is the number of remaining days Johan has
       - $b$ is the 
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
              "4 0 1 0 0 0\n",
              "300\n"
          ],
          [
              "5 0 1 0 1 0\n",
              "1900\n"
          ],
          [
              "6 0 1 1 0 0\n",
              "2300\n"
          ],
          [
              "10 399 0 0 0 0\n",
              "399\n"
          ],
          [
              "1 400 0 0 0 0\n",
              "500\n"
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
