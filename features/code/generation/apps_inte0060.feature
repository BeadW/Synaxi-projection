Feature: APPS/interview/60 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      A new airplane SuperPuperJet has an infinite number of rows, numbered with positive integers starting with 1 from cockpit to tail. There are six seats in each row, denoted with letters from 'a' to 'f'. Seats 'a', 'b' and 'c' are located to the left of an aisle (if one looks in the direction of the cockpit), while seats 'd', 'e' and 'f' are located to the right. Seats 'a' and 'f' are located near the windows, while seats 'c' and 'd' are located near the aisle.  [Image] 

 

      It's lunch time and two flight attendants have just started to serve food. They move from the first rows to the tail, always maintaining a distance of two rows from each other because of the food trolley. Thus, at the beginning the first attendant serves row 1 while the second attendant serves row 3. When both rows are done they move one row forward: the first attendant serves row 2 while the second attendant serves row 4. Then they move three rows forward and the first attendant serves row 5 while the second attendant serves row 7. Then they move one row forward again and so on.

      Flight attendants work with the same speed: it takes exactly 1 second to serve one passenger and 1 second to move one row forward. Each attendant first serves the passengers on the seats to the right of the aisle and then serves passengers on the seats to the left of the aisle (if one looks in the direction of the cockpit). Moreover, they always serve passengers in order from the window to the aisle. Thus, the first passenger to receive food in each row is located in seat 'f', and the last one — in seat 'c'. Assume that all seats are occupied.

      Vasya has seat s in row n and wants to know how many seconds will pass before he gets his lunch.


      -----Input-----

      The only line of input contains a description of Vasya's seat in the format ns, where n (1 ≤ n ≤ 10^18) is the index of the row and s is the seat in this row, denoted as letter from 'a' to 'f'. The index of the row and the seat are not separated by a space.


      -----Ou
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
              "1f\n",
              "1\n"
          ],
          [
              "2d\n",
              "10\n"
          ],
          [
              "4a\n",
              "11\n"
          ],
          [
              "5e\n",
              "18\n"
          ],
          [
              "2c\n",
              "13\n"
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
