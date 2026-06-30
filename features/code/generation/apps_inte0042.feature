Feature: APPS/interview/42 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a binary string $s$.

      Find the number of distinct cyclical binary strings of length $n$ which contain $s$ as a substring.

      The cyclical string $t$ contains $s$ as a substring if there is some cyclical shift of string $t$, such that $s$ is a substring of this cyclical shift of $t$.

      For example, the cyclical string "000111" contains substrings "001", "01110" and "10", but doesn't contain "0110" and "10110".

      Two cyclical strings are called different if they differ from each other as strings. For example, two different strings, which differ from each other by a cyclical shift, are still considered different cyclical strings.


      -----Input-----

      The first line contains a single integer $n$ ($1 \le n \le 40$) — the length of the target string $t$.

      The next line contains the string $s$ ($1 \le |s| \le n$) — the string which must be a substring of cyclical string $t$. String $s$ contains only characters '0' and '1'.


      -----Output-----

      Print the only integer — the number of distinct cyclical binary strings $t$, which contain $s$ as a substring.


      -----Examples-----
      Input
      2
      0

      Output
      3
      Input
      4
      1010

      Output
      2
      Input
      20
      10101010101010

      Output
      962


      -----Note-----

      In the first example, there are three cyclical strings, which contain "0" — "00", "01" and "10".

      In the second example, there are only two such strings — "1010", "0101".

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "2\n0\n",
              "3"
          ],
          [
              "4\n1010\n",
              "2"
          ],
          [
              "20\n10101010101010\n",
              "962"
          ],
          [
              "2\n11\n",
              "1"
          ],
          [
              "5\n00101\n",
              "5"
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
