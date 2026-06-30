Feature: APPS/interview/26 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Wet Shark asked Rat Kwesh to generate three positive real numbers x, y and z, from 0.1 to 200.0, inclusive. Wet Krash wants to impress Wet Shark, so all generated numbers will have exactly one digit after the decimal point.

      Wet Shark knows Rat Kwesh will want a lot of cheese. So he will give the Rat an opportunity to earn a lot of cheese. He will hand the three numbers x, y and z to Rat Kwesh, and Rat Kwesh will pick one of the these twelve options:  a_1 = x^{y}^{z};  a_2 = x^{z}^{y};  a_3 = (x^{y})^{z};  a_4 = (x^{z})^{y};  a_5 = y^{x}^{z};  a_6 = y^{z}^{x};  a_7 = (y^{x})^{z};  a_8 = (y^{z})^{x};  a_9 = z^{x}^{y};  a_10 = z^{y}^{x};  a_11 = (z^{x})^{y};  a_12 = (z^{y})^{x}. 

      Let m be the maximum of all the a_{i}, and c be the smallest index (from 1 to 12) such that a_{c} = m. Rat's goal is to find that c, and he asks you to help him. Rat Kwesh wants to see how much cheese he gets, so he you will have to print the expression corresponding to that a_{c}.

 


      -----Input-----

      The only line of the input contains three space-separated real numbers x, y and z (0.1 ≤ x, y, z ≤ 200.0). Each of x, y and z is given with exactly one digit after the decimal point.


      -----Output-----

      Find the maximum value of expression among x^{y}^{z}, x^{z}^{y}, (x^{y})^{z}, (x^{z})^{y}, y^{x}^{z}, y^{z}^{x}, (y^{x})^{z}, (y^{z})^{x}, z^{x}^{y}, z^{y}^{x}, (z^{x})^{y}, (z^{y})^{x} and print the corresponding expression. If there are many maximums, print the one that comes first in the list. 

      x^{y}^{z} should be outputted as x^y^z (without brackets), and (x^{y})^{z} should be outputted as (x^y)^z (quotes for clarity). 


      -----Examples-----
      Input
      1.1 3.4 2.5

      Output
      z^y^x

      Input
      2.0 2.0 2.0

      Output
      x^y^z

      Input
      1.9 1.8 1.7

      Output
      (x^y)^z

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "1.1 3.4 2.5\n",
              "z^y^x\n"
          ],
          [
              "2.0 2.0 2.0\n",
              "x^y^z\n"
          ],
          [
              "1.9 1.8 1.7\n",
              "(x^y)^z\n"
          ],
          [
              "2.0 2.1 2.2\n",
              "x^z^y\n"
          ],
          [
              "1.5 1.7 2.5\n",
              "(z^x)^y\n"
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
