Feature: APPS/interview/85 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Polycarpus likes giving presents to Paraskevi. He has bought two chocolate bars, each of them has the shape of a segmented rectangle. The first bar is a_1 × b_1 segments large and the second one is a_2 × b_2 segments large.

      Polycarpus wants to give Paraskevi one of the bars at the lunch break and eat the other one himself. Besides, he wants to show that Polycarpus's mind and Paraskevi's beauty are equally matched, so the two bars must have the same number of squares.

      To make the bars have the same number of squares, Polycarpus eats a little piece of chocolate each minute. Each minute he does the following:  he either breaks one bar exactly in half (vertically or horizontally) and eats exactly a half of the bar,  or he chips of exactly one third of a bar (vertically or horizontally) and eats exactly a third of the bar. 

      In the first case he is left with a half, of the bar and in the second case he is left with two thirds of the bar.

      Both variants aren't always possible, and sometimes Polycarpus cannot chip off a half nor a third. For example, if the bar is 16 × 23, then Polycarpus can chip off a half, but not a third. If the bar is 20 × 18, then Polycarpus can chip off both a half and a third. If the bar is 5 × 7, then Polycarpus cannot chip off a half nor a third.

      What is the minimum number of minutes Polycarpus needs to make two bars consist of the same number of squares? Find not only the required minimum number of minutes, but also the possible sizes of the bars after the process.


      -----Input-----

      The first line of the input contains integers a_1, b_1 (1 ≤ a_1, b_1 ≤ 10^9) — the initial sizes of the first chocolate bar. The second line of the input contains integers a_2, b_2 (1 ≤ a_2, b_2 ≤ 10^9) — the initial sizes of the second bar.

      You can use the data of type int64 (in Pascal), long long (in С++), long (in Java) to process large integers (exceeding 2^31 - 1).


      -----Output-----

      In the first line print m — the sought minimum number of minutes. In the 
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
              "2 6\n2 3\n",
              "1\n1 6\n2 3\n"
          ],
          [
              "36 5\n10 16\n",
              "3\n16 5\n5 16\n"
          ],
          [
              "3 5\n2 1\n",
              "-1\n"
          ],
          [
              "36 5\n10 12\n",
              "1\n24 5\n10 12\n"
          ],
          [
              "1 1\n1 1\n",
              "0\n1 1\n1 1\n"
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
