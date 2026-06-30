Feature: APPS/interview/73 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Mister B once received a gift: it was a book about aliens, which he started read immediately. This book had c pages.

      At first day Mister B read v_0 pages, but after that he started to speed up. Every day, starting from the second, he read a pages more than on the previous day (at first day he read v_0 pages, at second — v_0 + a pages, at third — v_0 + 2a pages, and so on). But Mister B is just a human, so he physically wasn't able to read more than v_1 pages per day.

      Also, to refresh his memory, every day, starting from the second, Mister B had to reread last l pages he read on the previous day. Mister B finished the book when he read the last page for the first time.

      Help Mister B to calculate how many days he needed to finish the book.


      -----Input-----

      First and only line contains five space-separated integers: c, v_0, v_1, a and l (1 ≤ c ≤ 1000, 0 ≤ l < v_0 ≤ v_1 ≤ 1000, 0 ≤ a ≤ 1000) — the length of the book in pages, the initial reading speed, the maximum reading speed, the acceleration in reading speed and the number of pages for rereading.


      -----Output-----

      Print one integer — the number of days Mister B needed to finish the book.


      -----Examples-----
      Input
      5 5 10 5 4

      Output
      1

      Input
      12 4 12 4 1

      Output
      3

      Input
      15 1 100 0 0

      Output
      15



      -----Note-----

      In the first sample test the book contains 5 pages, so Mister B read it right at the first day.

      In the second sample test at first day Mister B read pages number 1 - 4, at second day — 4 - 11, at third day — 11 - 12 and finished the book.

      In third sample test every day Mister B read 1 page of the book, so he finished in 15 days.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "5 5 10 5 4\n",
              "1\n"
          ],
          [
              "12 4 12 4 1\n",
              "3\n"
          ],
          [
              "15 1 100 0 0\n",
              "15\n"
          ],
          [
              "1 1 1 0 0\n",
              "1\n"
          ],
          [
              "1000 999 1000 1000 998\n",
              "2\n"
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
