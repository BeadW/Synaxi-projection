Feature: LiveCodeBench/atcoder/hard — Takahashi Quest
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Takahashi will embark on an adventure.
      During the adventure, N events will occur.
      The i-th event (1\leq i\leq N) is represented by a pair of integers (t _ i,x _ i) (1\leq t _ i\leq 2,1\leq x _ i\leq N) and is as follows:

      - If t _ i=1, he finds one potion of type x _ i. He can choose to pick it up or discard it.
      - If t _ i=2, he encounters one monster of type x _ i. If he has a potion of type x _ i, he can use one to defeat the monster. If he does not defeat it, he will be defeated.

      Determine whether he can defeat all the monsters without being defeated.
      If he cannot defeat all the monsters, print -1.
      Otherwise, let K be the maximum number of potions he has at some point during the adventure.
      Let K _ {\min} be the minimum value of K across all strategies where he will not be defeated.
      Print the value of K _ {\min} and the actions of Takahashi that achieve K _ {\min}.

      Input

      The input is given from Standard Input in the following format:
      N
      t _ 1 x _ 1
      t _ 2 x _ 2
      \vdots
      t _ N x _ N

      Output

      If Takahashi cannot defeat all the monsters, print -1.
      If he can, print the value of K _ {\min} in the first line, and in the second line, for each i such that t _ i=1 in ascending order, print 1 if he picks up the potion found at the i-th event, and 0 otherwise, separated by spaces.
      If multiple sequences of actions achieve K _ {\min} and allow him to finish the adventure without being defeated, you may print any of them.

      Constraints


      - 1\leq N\leq2\times10^5
      - 1\leq t _ i\leq2\ (1\leq i\leq N)
      - 1\leq x _ i\leq N\ (1\leq i\leq N)
      - All input values are integers.

      Sample Input 1

      13
      1 2
      1 3
      1 1
      1 3
      1 2
      2 3
      1 3
      1 3
      2 3
      1 3
      2 2
      2 3
      2 1

      Sample Output 1

      3
      1 1 1 0 0 1 0 1

      The sample output corresponds to the following actions:

      - Find potions of types 2,3,1 in this order. Pick up all of them.
      - Find potions of types 3,2 in this order. Do not pick up any of them.
      - Encounter a type-3 monster. Use one type-3 potion to defeat it.
      - Find a type-3 potion. Pick

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "13\n1 2\n1 3\n1 1\n1 3\n1 2\n2 3\n1 3\n1 3\n2 3\n1 3\n2 2\n2 3\n2 1\n",
              "3\n1 1 1 0 0 1 0 1\n"
          ],
          [
              "4\n2 3\n1 4\n2 1\n1 2\n",
              "-1\n"
          ],
          [
              "30\n1 25\n1 2\n1 10\n1 18\n2 18\n1 11\n2 11\n1 21\n1 6\n2 2\n2 10\n1 11\n1 24\n1 11\n1 3\n1 2\n1 18\n2 25\n1 8\n1 10\n1 11\n2 18\n2 10\n1 10\n2 2\n1 24\n1 10\n2 10\n1 25\n2 6\n",
              "4\n1 1 1 1 1 1 0 1 1 0 0 0 0 1 0 0 1 0 0 0\n"
          ]
      ]


      def test_lcb():
          for i, (inp, expected) in enumerate(TEST_CASES):
              r = subprocess.run(
                  [sys.executable, "solution.py"],
                  input=inp,
                  capture_output=True,
                  text=True,
                  timeout=10,
              )
              assert r.returncode == 0, f"Case {i}: runtime error\n{r.stderr[:400]}"
              assert r.stdout.strip() == expected.strip(), (
                  f"Case {i}: expected {expected!r}, got {r.stdout!r}"
              )

      """

  Scenario: Agent solves the LiveCodeBench problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
