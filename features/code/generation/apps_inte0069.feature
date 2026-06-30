Feature: APPS/interview/69 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given string $s$ of length $n$ consisting of 0-s and 1-s. You build an infinite string $t$ as a concatenation of an infinite number of strings $s$, or $t = ssss \dots$ For example, if $s =$ 10010, then $t =$ 100101001010010...

      Calculate the number of prefixes of $t$ with balance equal to $x$. The balance of some string $q$ is equal to $cnt_{0, q} - cnt_{1, q}$, where $cnt_{0, q}$ is the number of occurrences of 0 in $q$, and $cnt_{1, q}$ is the number of occurrences of 1 in $q$. The number of such prefixes can be infinite; if it is so, you must say that.

      A prefix is a string consisting of several first letters of a given string, without any reorders. An empty prefix is also a valid prefix. For example, the string "abcd" has 5 prefixes: empty string, "a", "ab", "abc" and "abcd".


      -----Input-----

      The first line contains the single integer $T$ ($1 \le T \le 100$) — the number of test cases.

      Next $2T$ lines contain descriptions of test cases — two lines per test case. The first line contains two integers $n$ and $x$ ($1 \le n \le 10^5$, $-10^9 \le x \le 10^9$) — the length of string $s$ and the desired balance, respectively.

      The second line contains the binary string $s$ ($|s| = n$, $s_i \in \{\text{0}, \text{1}\}$).

      It's guaranteed that the total sum of $n$ doesn't exceed $10^5$.


      -----Output-----

      Print $T$ integers — one per test case. For each test case print the number of prefixes or $-1$ if there is an infinite number of such prefixes.


      -----Example-----
      Input
      4
      6 10
      010010
      5 3
      10101
      1 0
      0
      2 0
      01

      Output
      3
      0
      1
      -1



      -----Note-----

      In the first test case, there are 3 good prefixes of $t$: with length $28$, $30$ and $32$.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "4\n6 10\n010010\n5 3\n10101\n1 0\n0\n2 0\n01\n",
              "3\n0\n1\n-1\n"
          ],
          [
              "2\n1 -548706795\n0\n1 -735838406\n1\n",
              "0\n1\n"
          ],
          [
              "1\n5 5\n00000\n",
              "1\n"
          ],
          [
              "19\n1 1\n1\n1 1\n1\n1 1\n1\n1 1\n1\n1 1\n1\n1 1\n1\n1 1\n1\n1 1\n1\n1 1\n1\n1 1\n1\n1 1\n1\n1 1\n1\n1 1\n1\n1 1\n1\n1 1\n1\n1 1\n1\n1 1\n1\n1 1\n1\n1 1\n1\n",
              "0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n"
          ],
          [
              "1\n3 0\n011\n",
              "3\n"
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
