Feature: APPS/interview/90 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Anya loves to fold and stick. Today she decided to do just that.

      Anya has n cubes lying in a line and numbered from 1 to n from left to right, with natural numbers written on them. She also has k stickers with exclamation marks. We know that the number of stickers does not exceed the number of cubes.

      Anya can stick an exclamation mark on the cube and get the factorial of the number written on the cube. For example, if a cube reads 5, then after the sticking it reads 5!, which equals 120.

      You need to help Anya count how many ways there are to choose some of the cubes and stick on some of the chosen cubes at most k exclamation marks so that the sum of the numbers written on the chosen cubes after the sticking becomes equal to S. Anya can stick at most one exclamation mark on each cube. Can you do it?

      Two ways are considered the same if they have the same set of chosen cubes and the same set of cubes with exclamation marks.


      -----Input-----

      The first line of the input contains three space-separated integers n, k and S (1 ≤ n ≤ 25, 0 ≤ k ≤ n, 1 ≤ S ≤ 10^16) — the number of cubes and the number of stickers that Anya has, and the sum that she needs to get. 

      The second line contains n positive integers a_{i} (1 ≤ a_{i} ≤ 10^9) — the numbers, written on the cubes. The cubes in the input are described in the order from left to right, starting from the first one. 

      Multiple cubes can contain the same numbers.


      -----Output-----

      Output the number of ways to choose some number of cubes and stick exclamation marks on some of them so that the sum of the numbers became equal to the given number S.


      -----Examples-----
      Input
      2 2 30
      4 3

      Output
      1

      Input
      2 2 7
      4 3

      Output
      1

      Input
      3 1 1
      1 1 1

      Output
      6



      -----Note-----

      In the first sample the only way is to choose both cubes and stick an exclamation mark on each of them.

      In the second sample the only way is to choose both cubes but don't stick an exclamation mark on any of them.

      In the third sample it is possible to choos
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
              "2 2 30\n4 3\n",
              "1\n"
          ],
          [
              "2 2 7\n4 3\n",
              "1\n"
          ],
          [
              "3 1 1\n1 1 1\n",
              "6\n"
          ],
          [
              "25 25 25\n1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1\n",
              "33554432\n"
          ],
          [
              "13 1 60\n3 6 3 4 3 5 1 4 4 4 3 4 3\n",
              "155\n"
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
