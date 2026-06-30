Feature: APPS/competition/3002 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Every modern car has an odometer. It measures how far the car has traveled, and is used, among other things, to decide when to service a car. Sometimes, however, unscrupulous characters who want to sell a car might tamper with its odometer to make the car seem younger than it is. 

      Tommy Catkins wants to buy a used car, and has asked you to help him figure out if it has been serviced appropriately. You happen to know with certainty that the only previous owner of the car Tommy is interested in was a travelling salescat who drove at least $2000$ km and at most $20000$ km every single month. In addition, by Catland law, each car should be serviced at least every $30000$ km or $12$ months, whichever comes first, but you do not know if this has actually been done or not.

      The service history entries indicate the approximate time the service took place, and the reading of the odometer at that time. The maximum distance the odometer can measure is $99999$ km. Upon reaching $100000$ km traveled, the odometer resets to $0$ km. In addition, the entries do not indicate exact time, only the year and month. In particular, even though you know that the car traveled between $2000$ and $20000$ km every month, you do not know how much of that distance was traveled before the service. For the purpose of the $12$ month rule, it does not matter which day during the month a service took place. For instance, it is perfectly fine if a service takes place on January 1 2017, and then the next service takes place on January 31 2018 (assuming the car did not travel more than $30000$ km during this time).

      Given the service history entries, you must first determine whether it is possible that these are correct, or whether it can be conclusively proven that the odometer must have been tampered with. In the former case, assuming the odometer has not been tampered with, you must then determine whether or not the car has been serviced sufficiently often.

      -----Input-----
      The first line of input c
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
              "3\n2017 4 0\n2017 8 12000\n2018 8 42000\n",
              "seems legit\n"
          ],
          [
              "3\n2017 4 0\n2017 8 12000\n2018 8 42001\n",
              "insufficient service\n"
          ],
          [
              "2\n2017 11 0\n2018 1 1000\n",
              "tampered odometer\n"
          ],
          [
              "2\n2013 1 0\n2013 2 0\n",
              "seems legit\n"
          ],
          [
              "2\n1980 1 0\n1980 6 1000\n",
              "insufficient service\n"
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
