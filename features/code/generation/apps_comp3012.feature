Feature: APPS/competition/3012 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      RB is a basketball coach and he has several teams of exceptionally skilled basketball players, who dominate basketball leagues all over the world.

      Why are RB’s players so good? The reason is that each of them has already mastered exactly one ball trick – either the Triple Spin, or the Power Charge. For convenience, we call the former trick 1 and the latter trick 2. These two tricks are extremely effective in attack.

      Besides mastering such powerful trick, each of them also knows how to defend against exactly one ball trick. Therefore, one of their popular training routines is to let two players play against each other, one using a trick and the other trying to defend against it. We call this a move. The one who uses a trick is called an attacker, and the other is called a defender.

      RB’s team can perform sequences of moves. To state it more concisely, we use the notation $(\text {Attacker}, \text {Defender})$ to represent a move. Suppose the current move is $(\texttt{A}, \texttt{B})$. A performs the only trick he knows.
       - If A attacks successfully (i.e., B fails to defend), the next move will normally be $(\texttt{A}, \texttt{C})$ for some other player C.
       - However, if it is the third consecutive time A attacks successfully, A will have to take a rest for the next two moves and the next move will be $(\texttt{C}, \texttt{D})$ for some other players C and D.
       - If A fails (i.e., B defends successfully), the next move will be $(\texttt{B}, \texttt{C})$ for some other player C.

      Note that in all cases, A, B, C, and D must be pairwise distinct players. In addition, C and D must not be at rest for the next move.


      Today, RB inspects the team training. He is interested in sequences of moves of length exactly $N$. How many different sequences of moves of length $N$ are there? Two sequences of moves\[ ((\mathrm{ATK}_1, \mathrm{DEF}_1), (\mathrm{ATK}_2, \mathrm{DEF}_2), \ldots , (\mathrm{ATK}_ N, \mathrm{DEF}_ N)) \]

      and\[ ((\mathrm{ATK}_1^{'}, \mathrm{DEF}_1^{'}), (\mat
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
              "3 0 0 0 3\n",
              "6\n"
          ],
          [
              "1 2 0 0 5\n",
              "2\n"
          ],
          [
              "1 2 0 0 4\n",
              "4\n"
          ],
          [
              "1 2 0 0 6\n",
              "0\n"
          ],
          [
              "369 777 2000 913 123456789012345678\n",
              "460130848\n"
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
