Feature: APPS/competition/3015 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Harry the Hamster lives in a giant hamster cage. Inside the cage there is a set of $n$ plastic balls connected by unidirectional hamster tubes of varying lengths. Harry is currently in ball $s$ and his bed is in ball $t$.

      Being a simple hamster, the hemispheres of Harry’s brain are not so great at communicating with each other and have a mind of their own. Harry’s left hemisphere, usually being active when Harry is in the hamster wheel, likes running for as long as possible. Harry’s right hemisphere, rarely active at all, would like to go to sleep as soon as possible. Together, Harry’s hemispheres will be navigating Harry through the maze of tubes, in each ball deciding which of the outgoing tubes to follow.

      Harry’s hemispheres get really tired after making a decision and then need to rest a bit, so they cannot make two decisions in a row. Thus, they make decisions on which tube to take in alternating turns, with the left hemisphere going first. So starting in ball $s$, Harry’s left hemisphere will decide on a tube to follow, ending in some ball $u$, where Harry’s left hemisphere will rest and Harry’s right hemisphere will pick an outgoing tube, et cetera.

      Counterintuitively, the hemispheres are familiar with the entire hamster cage and can plan arbitrarily far ahead. Assuming both hemispheres make optimal decisions, how long will it take for Harry to reach his bed? It is guaranteed that each ball has at least one outgoing tube, except the ball containing Harry’s bed which has none (there Harry will rest easily). There are no tubes connecting a ball to itself, but there may be multiple tubes going from one ball to another.

      -----Input-----
       - On the first line are four space-separated integers: the number of plastic balls $1 \leq n \leq 10^5$, the number of tubes $0 \leq m \leq 2 \cdot 10^5$, and the locations of Harry and his bed $0 \leq s, t < n$.
       - Then $m$ lines follow, each containing three space-separated integers describing a single tube: the ball in whic
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
              "4 5 0 3\n0 1 1\n1 2 2\n2 0 4\n2 3 1\n2 3 3\n",
              "11\n"
          ],
          [
              "5 5 0 4\n0 1 1\n1 2 1\n2 3 1\n3 0 1\n2 4 1\n",
              "infinity\n"
          ],
          [
              "2 1 0 1\n0 1 2\n",
              "2\n"
          ],
          [
              "3 3 1 2\n0 1 1\n1 0 1\n1 2 1\n",
              "infinity\n"
          ],
          [
              "3 2 0 1\n0 2 3\n2 0 3\n",
              "infinity\n"
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
