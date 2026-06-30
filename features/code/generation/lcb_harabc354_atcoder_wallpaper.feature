Feature: LiveCodeBench/atcoder/hard — AtCoder Wallpaper
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      The pattern of AtCoder's wallpaper can be represented on the xy-plane as follows:

      - 
      The plane is divided by the following three types of lines:

      - 
      x = n (where n is an integer)

      - 
      y = n (where n is an even number)

      - 
      x + y = n (where n is an even number)



      - 
      Each region is painted black or white. Any two regions adjacent along one of these lines are painted in different colors.

      - 
      The region containing (0.5, 0.5) is painted black.


      The following figure shows a part of the pattern.

      You are given integers A, B, C, D. Consider a rectangle whose sides are parallel to the x- and y-axes, with its bottom-left vertex at (A, B) and its top-right vertex at (C, D). Calculate the area of the regions painted black inside this rectangle, and print twice that area.
      It can be proved that the output value will be an integer.

      Input

      The input is given from Standard Input in the following format:
      A B C D

      Output

      Print the answer on a single line.

      Constraints


      - -10^9 \leq A, B, C, D \leq 10^9
      - A < C and B < D.
      - All input values are integers.

      Sample Input 1

      0 0 3 3

      Sample Output 1

      10

      We are to find the area of the black-painted region inside the following square:

      The area is 5, so print twice that value: 10.

      Sample Input 2

      -1 -2 1 3

      Sample Output 2

      11

      The area is 5.5, which is not an integer, but the output value is an integer.

      Sample Input 3

      -1000000000 -1000000000 1000000000 1000000000

      Sample Output 3

      4000000000000000000

      This is the case with the largest rectangle, where the output still fits into a 64-bit signed integer.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "0 0 3 3\n",
              "10\n"
          ],
          [
              "-1 -2 1 3\n",
              "11\n"
          ],
          [
              "-1000000000 -1000000000 1000000000 1000000000\n",
              "4000000000000000000\n"
          ]
      ]


      def test_lcb():
          for i, (inp, expected) in enumerate(TEST_CASES):
              r = subprocess.run(
                  [sys.executable, "solution.py"],
                  input=inp,
                  capture_output=True,
                  text=True,
                  timeout=10,
              )
              assert r.returncode == 0, f"Case {i}: runtime error\n{r.stderr[:400]}"
              assert r.stdout.strip() == expected.strip(), (
                  f"Case {i}: expected {expected!r}, got {r.stdout!r}"
              )

      """

  Scenario: Agent solves the LiveCodeBench problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
