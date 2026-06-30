Feature: APPS/competition/3041 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Johan lives in Stockholm, which means he has to travel a lot by bus and subway. To travel, he needs to pay a number of coupons, depending on which zones his trip goes between.

      A ticket is specified by an interval $[A, B]$ of zones it is valid in, and costs $2 + |A - B|$ coupons to purchase. When Johan buys a ticket, it is valid for exactly $10000$ seconds and can be used for any trip which both starts and ends in zones in the interval $[A, B]$.

      Johan is now going to make $N$ trips in order. For each trip, you will be given the zone Johan travels to, as well as the time at which he starts his trip. Initially, Johan is located in zone $0$. Help him minimize the number of coupons he must purchase!

      Notes: Johan can buy a new ticket at any point, even if he already has a valid ticket. A ticket only needs to be valid at the moment Johan starts a trip, it is OK if the $10000$ seconds expire while Johan is taking the trip.

      -----Input-----
      The first line contains the integer $0 \le N \le 400000$ – the number of trips Johan wants to make.

      The next $N$ lines contains two space-separated integers $0 \le Z \le 10$ and $0 \le T \le 10^9$, the zone and time for Johan’s next trip (in seconds from now). The values of $T$ will be strictly increasing.

      -----Output-----
      The first and only line should contain a single integer: the minimum number of coupons Johan must purchase to make all his trips.

      -----Examples-----
      Sample Input 1:
      2
      1 4
      2 5
      Sample Output 1:
      4

      Sample Input 2:
      2
      1 4
      2 10005
      Sample Output 2:
      6

      Sample Input 3:
      3
      1 4
      2 10
      0 15
      Sample Output 3:
      4

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "2\n1 4\n2 5\n",
              "4\n"
          ],
          [
              "2\n1 4\n2 10005\n",
              "6\n"
          ],
          [
              "3\n1 4\n2 10\n0 15\n",
              "4\n"
          ],
          [
              "2\n1 4\n2 10004\n",
              "4\n"
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
