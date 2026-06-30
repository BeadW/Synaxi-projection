Feature: APPS/competition/3034 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      The Bluewater Geocloud Organization (BGO) has recently developed brand new software able to predict with pinpoint precision at which second any particular cloud will start and stop raining, and with what intensity. There is, however, some uncertainty about how a cloud will move around; for each zip code, each cloud will be over that zip code with some probability.

      You have scraped some information about your zip code from the BGO website, and want to use it to plan your walk to the bus stop. You wish to minimize the expected amount of rain that would fall on you. To reach the bus you must get to the bus stop within $t$ seconds from now. You have timed your walking speed to be exactly $1 \frac{m}{s}$.

      To complicate matters, some parts of the walk to the bus are covered by roofs where it might be beneficial to make shorts breaks whilst waiting for the worst rain to pass. Your front door (at $d$ meters from the bus stop) is always under a roof – but the bus stop need not be.

      -----Input-----
      The first line of input is four space-separated integers: $d$ ($1 \leq d \leq 1000$), the distance to the bus stop in meters, $t$ ($d \leq t \leq 10000$) the time until the bus leaves, $c$ ($0 \leq c \leq 1000000$), the number of clouds tracked by BGO, and finally $r$ ($0 \leq r \leq d$), the number of roofs. The next $c$ lines describe the clouds; the $i$’th such line contains four numbers $s_ i$, $e_ i$, $p_ i$ and $a_ i$ describing the $i$’th cloud:
       - $s_ i$ ($0 \leq s_ i < t$) is an integer giving the number of seconds until the cloud starts its raining period,
       - $e_ i$ ($s_ i < e_ i \leq t$) is an integer giving the number of seconds until the cloud ends its raining period,
       - $p_ i$ ($0 \leq p_ i \leq 1$) is a real number (with at most $6$ digits after the decimal point) giving the probability that the cloud is in your zip code during its raining period, and
       - $a_ i$ ($0 \leq a_ i \leq 100$) is an integer indicating the amount of rain the cloud will release during its ra
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
              "20 60 2 1\n5 15 0.33333 30\n22 60 0.66666 70\n0 10\n",
              "466.662\n"
          ],
          [
              "3 4 2 1\n1 3 0.25 8\n2 4 0.66667 15\n1 2\n",
              "10.00005\n"
          ],
          [
              "3 4 1 0\n0 2 0.25 8\n",
              "2.0\n"
          ],
          [
              "3 5 2 1\n0 3 0.125 32\n2 5 0.5 32\n3 4\n",
              "28.0\n"
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
