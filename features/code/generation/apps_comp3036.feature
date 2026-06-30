Feature: APPS/competition/3036 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      The world-renowned Swedish Chef is planning a gourmet three-course dinner for some muppets: a starter course, a main course, and a dessert. His famous Swedish cook-book offers a wide variety of choices for each of these three courses, though some of them do not go well together (for instance, you of course cannot serve chocolate moose and sooted shreemp at the same dinner). 

      Each potential dish has a list of ingredients. Each ingredient is in turn available from a few different brands. Each brand is of course unique in its own special way, so using a particular brand of an ingredient will always result in a completely different dinner experience than using another brand of the same ingredient.

      Some common ingredients such as pølårber may appear in two of the three chosen dishes, or in all three of them. When an ingredient is used in more than one of the three selected dishes, Swedish Chef will use the same brand of the ingredient in all of them.

      While waiting for the meecaroo, Swedish Chef starts wondering: how many different dinner experiences are there that he could make, by different choices of dishes and brands for the ingredients?

      -----Input-----
      The input consists of:
       - one line containing five integers $r$, $s$, $m$, $d$, $n$, where $1 \le r \le 1000$ is the number of different ingredients that exist, $1 \le s, m, d \le 25$ are the number of available starter dishes, main dishes, and desserts, respectively, and $0 \le n \le 2000$ is the number of pairs of dishes that do not go well together.
       - one line containing $r$ integers $b_1, \ldots , b_ r$, where $1 \le b_ i \le 100$ is the number of different brands of ingredient $i$.
       - $s+m+d$ lines describing the $s$ starter dishes, then the $m$ main dishes, then the $d$ desserts. Each such line starts with an integer $1 \le k \le 20$ denoting the number of ingredients of the dish, and is followed by $k$ distinct integers $i_1, \ldots , i_ k$, where for each $1 \le j \le k$, $1 \le i_ j \le r$ is an ingredien
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
              "6 1 1 1 0\n2 3 1 5 3 2\n2 1 2\n3 3 4 5\n1 6\n",
              "180\n"
          ],
          [
              "3 2 2 1 1\n2 3 2\n1 1\n1 2\n1 2\n1 3\n1 1\n2 3\n",
              "22\n"
          ],
          [
              "3 1 1 1 1\n5 5 5\n3 1 2 3\n3 1 2 3\n3 1 2 3\n2 1\n",
              "0\n"
          ],
          [
              "10 1 1 1 0\n100 100 100 100 100 100 100 100 100 100\n4 1 2 3 4\n3 5 6 7\n3 8 9 10\n",
              "too many\n"
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
