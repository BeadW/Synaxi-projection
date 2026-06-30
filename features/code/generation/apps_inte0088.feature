Feature: APPS/interview/88 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      The year 2015 is almost over.

      Limak is a little polar bear. He has recently learnt about the binary system. He noticed that the passing year has exactly one zero in its representation in the binary system — 2015_10 = 11111011111_2. Note that he doesn't care about the number of zeros in the decimal representation.

      Limak chose some interval of years. He is going to count all years from this interval that have exactly one zero in the binary representation. Can you do it faster?

      Assume that all positive integers are always written without leading zeros.


      -----Input-----

      The only line of the input contains two integers a and b (1 ≤ a ≤ b ≤ 10^18) — the first year and the last year in Limak's interval respectively.


      -----Output-----

      Print one integer – the number of years Limak will count in his chosen interval.


      -----Examples-----
      Input
      5 10

      Output
      2

      Input
      2015 2015

      Output
      1

      Input
      100 105

      Output
      0

      Input
      72057594000000000 72057595000000000

      Output
      26



      -----Note-----

      In the first sample Limak's interval contains numbers 5_10 = 101_2, 6_10 = 110_2, 7_10 = 111_2, 8_10 = 1000_2, 9_10 = 1001_2 and 10_10 = 1010_2. Two of them (101_2 and 110_2) have the described property.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "5 10\n",
              "2\n"
          ],
          [
              "2015 2015\n",
              "1\n"
          ],
          [
              "100 105\n",
              "0\n"
          ],
          [
              "72057594000000000 72057595000000000\n",
              "26\n"
          ],
          [
              "1 100\n",
              "16\n"
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
