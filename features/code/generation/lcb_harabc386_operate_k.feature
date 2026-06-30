Feature: LiveCodeBench/atcoder/hard — Operate K
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      This problem fully contains Problem C (Operate 1), with K \le 20.
      You can solve Problem C by submitting a correct solution to this problem for Problem C.
      Determine whether it is possible to perform the following operation on string S between 0 and K times, inclusive, to make it identical to string T.

      - Choose one of the following three operations and execute it.
      - Insert any one character at any position in S (possibly the beginning or end).
      - Delete one character from S.
      - Choose one character in S and replace it with another character.

      Input

      The input is given from Standard Input in the following format:
      K
      S
      T

      Output

      If S can be made identical to T with at most K operations, print Yes; otherwise, print No.

      Constraints


      - Each of S and T is a string of length between 1 and 500000, inclusive, consisting of lowercase English letters.
      - K is an integer satisfying \color{red}{1 \le K \le 20}.

      Sample Input 1

      3
      abc
      awtf

      Sample Output 1

      Yes

      For example, here is a way to convert abc to awtf with three operations:

      - Replace the second character b with w. After the operation, the string becomes awc.
      - Replace the third character c with f. After the operation, the string becomes awf.
      - Insert t between the second and third characters. After the operation, the string becomes awtf.

      Sample Input 2

      2
      abc
      awtf

      Sample Output 2

      No

      abc cannot be converted to awtf with two or fewer operations.

      Sample Input 3

      17
      twothousandtwentyfour
      happynewyear

      Sample Output 3

      Yes

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\nabc\nawtf",
              "Yes"
          ],
          [
              "2\nabc\nawtf",
              "No"
          ],
          [
              "17\ntwothousandtwentyfour\nhappynewyear",
              "Yes"
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
