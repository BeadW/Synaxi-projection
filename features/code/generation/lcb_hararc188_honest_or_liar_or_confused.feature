Feature: LiveCodeBench/atcoder/hard — Honest or Liar or Confused
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a village with N villagers numbered from 1 to N.
      Each villager is honest or a liar. Additionally, some villagers are confused.
      You have obtained M testimonies from the villagers. Each testimony is given by A_i, B_i, C_i for i=1,2,\ldots,M, representing:

      - If C_i=0, villager A_i testified that villager B_i is honest.
      - If C_i=1, villager A_i testified that villager B_i is a liar.

      All villagers know whether every other villager is honest or a liar, and you know that they made their testimonies to you according to the following rules:

      - An honest villager who is not confused always tells the truth.
      - A liar who is not confused always tells lies.
      - A confused honest villager always tells lies.
      - A confused liar always tells the truth.

      In other words, if they are not confused, honest villagers always tell the truth, and liars always tell lies, but if they are confused, it is reversed.
      You have decided to guess the set of villagers who are confused.
      Given a choice of villagers who are confused, whether the set of testimonies "contradicts" or not is determined.
      Here, a set of testimonies is said to contradict if, no matter how you assign honest or liar statuses to the villagers, there is at least one testimony that violates the villagers' testimony rules.
      Find a set of confused villagers such that the given set of testimonies does not contradict.
      If no such set of confused villagers exists, indicate that fact.

      Input

      The input is given from Standard Input in the following format:
      N M
      A_1 B_1 C_1
      A_2 B_2 C_2
      \vdots
      A_M B_M C_M

      Output

      If there exists a set of confused villagers such that the given set of testimonies does not contradict, print a string of length N representing the set of confused villagers. In this string, the i-th character should be 1 if villager i is confused, and 0 otherwise.
      If no such set of confused villagers exists, print -1.

      Constraints


      - 2 \leq N \leq 2 \times 10^5
      - 0 \leq M \leq \mathrm{min} \lbrace 2 \times 10^5,N(N-1) \rbrace 

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 3\n1 2 1\n1 3 0\n2 3 0",
              "010"
          ],
          [
              "3 6\n1 2 1\n1 3 0\n2 1 1\n2 3 0\n3 1 1\n3 2 0",
              "-1"
          ],
          [
              "3 0",
              "000"
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
