Feature: APPS/interview/44 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Vasiliy has a car and he wants to get from home to the post office. The distance which he needs to pass equals to d kilometers.

      Vasiliy's car is not new — it breaks after driven every k kilometers and Vasiliy needs t seconds to repair it. After repairing his car Vasiliy can drive again (but after k kilometers it will break again, and so on). In the beginning of the trip the car is just from repair station.

      To drive one kilometer on car Vasiliy spends a seconds, to walk one kilometer on foot he needs b seconds (a < b).

      Your task is to find minimal time after which Vasiliy will be able to reach the post office. Consider that in every moment of time Vasiliy can left his car and start to go on foot.


      -----Input-----

      The first line contains 5 positive integers d, k, a, b, t (1 ≤ d ≤ 10^12; 1 ≤ k, a, b, t ≤ 10^6; a < b), where:  d — the distance from home to the post office;  k — the distance, which car is able to drive before breaking;  a — the time, which Vasiliy spends to drive 1 kilometer on his car;  b — the time, which Vasiliy spends to walk 1 kilometer on foot;  t — the time, which Vasiliy spends to repair his car. 


      -----Output-----

      Print the minimal time after which Vasiliy will be able to reach the post office.


      -----Examples-----
      Input
      5 2 1 4 10

      Output
      14

      Input
      5 2 1 4 5

      Output
      13



      -----Note-----

      In the first example Vasiliy needs to drive the first 2 kilometers on the car (in 2 seconds) and then to walk on foot 3 kilometers (in 12 seconds). So the answer equals to 14 seconds.

      In the second example Vasiliy needs to drive the first 2 kilometers on the car (in 2 seconds), then repair his car (in 5 seconds) and drive 2 kilometers more on the car (in 2 seconds). After that he needs to walk on foot 1 kilometer (in 4 seconds). So the answer equals to 13 seconds.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "5 2 1 4 10\n",
              "14\n"
          ],
          [
              "5 2 1 4 5\n",
              "13\n"
          ],
          [
              "1 1 1 2 1\n",
              "1\n"
          ],
          [
              "1000000000000 1000000 999999 1000000 1000000\n",
              "999999999999000000\n"
          ],
          [
              "997167959139 199252 232602 952690 802746\n",
              "231947279018960454\n"
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
