Feature: APPS/competition/3008 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      The online retailer Amagoogsoftbook currently offers $N$ different so-called “home assistants”, which it wants to recommend to its customers. For this recommendation, they wish to rank all the assistants. The quality of this ranking is not very important – multiple assistants may even be assigned the same rank – but they wish to maximize the number of distinct ranks assigned, to lessen the decision fatigue of their customers.

      To ensure that the ranking is not completely arbitrary, they have collected for each assistant $i$ two measurements $a_ i$ and $b_ i$ – the quality of the jokes the assistant can tell and how nice are the compliments the assistant is able to give (clearly these are the two most important aspects). These measurements are of course somewhat subjective, so we wish to ignore small differences in them. However, if for two given assistants $i$ and $j$ we have that $a_ i + K < a_ j$ or $b_ i + K < b_ j$, the ranking of assistant $j$ must be the same or higher than the ranking of assistant $i$. This rule may force two products to be given the same ranking, for example if an assistant $i$ gives much better puns than assistant $j$, while assistant $j$ gives the superior self-esteem boosts.

      What is the maximum number of distinct ranks, taken over all possible rankings?

      -----Input-----
      The first line contains the integers $1 \le N \le 100000$ and $0 \le K \le 10^9$ – the number of assistants and the measurement difference limit as described in the statement. The next line contains the $N$ integers $a_1, a_2, \dots , a_ N$. The next line contains the $N$ integers $b_1, b_2, \dots , b_ N$.

      All measurements are between $0$ and $10^9$.

      -----Output-----
      Output a single integer: the maximum number of distinct ranks.

      -----Examples-----
      Sample Input 1:
      2 10
      1 12
      1 13
      Sample Output 1:
      2

      Sample Input 2:
      2 10
      1 5
      1 12
      Sample Output 2:
      2

      Sample Input 3:
      2 10
      1 5
      1 4
      Sample Output 3:
      2

      Sample Input 4:
      2 10
      1 5
      4 1
      Sample Output 4:
      2

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "2 10\n1 12\n1 13\n",
              "2\n"
          ],
          [
              "2 10\n1 5\n1 12\n",
              "2\n"
          ],
          [
              "2 10\n1 5\n1 4\n",
              "2\n"
          ],
          [
              "2 10\n1 5\n4 1\n",
              "2\n"
          ],
          [
              "2 10\n1 12\n13 1\n",
              "1\n"
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
