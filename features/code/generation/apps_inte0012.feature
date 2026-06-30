Feature: APPS/interview/12 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Vova has won $n$ trophies in different competitions. Each trophy is either golden or silver. The trophies are arranged in a row.

      The beauty of the arrangement is the length of the longest subsegment consisting of golden trophies. Vova wants to swap two trophies (not necessarily adjacent ones) to make the arrangement as beautiful as possible — that means, to maximize the length of the longest such subsegment.

      Help Vova! Tell him the maximum possible beauty of the arrangement if he is allowed to do at most one swap.


      -----Input-----

      The first line contains one integer $n$ ($2 \le n \le 10^5$) — the number of trophies.

      The second line contains $n$ characters, each of them is either G or S. If the $i$-th character is G, then the $i$-th trophy is a golden one, otherwise it's a silver trophy. 


      -----Output-----

      Print the maximum possible length of a subsegment of golden trophies, if Vova is allowed to do at most one swap.


      -----Examples-----
      Input
      10
      GGGSGGGSGG

      Output
      7

      Input
      4
      GGGG

      Output
      4

      Input
      3
      SSS

      Output
      0



      -----Note-----

      In the first example Vova has to swap trophies with indices $4$ and $10$. Thus he will obtain the sequence "GGGGGGGSGS", the length of the longest subsegment of golden trophies is $7$. 

      In the second example Vova can make no swaps at all. The length of the longest subsegment of golden trophies in the sequence is $4$. 

      In the third example Vova cannot do anything to make the length of the longest subsegment of golden trophies in the sequence greater than $0$.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "10\nGGGSGGGSGG\n",
              "7\n"
          ],
          [
              "4\nGGGG\n",
              "4\n"
          ],
          [
              "3\nSSS\n",
              "0\n"
          ],
          [
              "11\nSGGGGSGGGGS\n",
              "8\n"
          ],
          [
              "300\nSSGSGSSSGSGSSSSGGSGSSGGSGSGGSSSGSSGSGGSSGGSGSSGGSGGSSGSSSGSGSGSSGSGGSSSGSSGSSGGGGSSGSSGSSGSGGSSSSGGGGSSGSSSSSSSSGSSSSGSGSSSSSSSSGSGSSSSGSSGGSSGSGSSSSSSGSGSSSGGSSGSGSSGSSSSSSGGGSSSGSGSGSGGSGGGSSGSGSSSGSSGGSSGSSGGGGSGSSGSSSSGGSSSSGGSGSSSSSSGSSSGGGSGSGGSSGSSSSSSGGSSSGSSSSGGGSSGSSSGSGGGSSSSGSSSGSGSGGGGS\n",
              "6\n"
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
