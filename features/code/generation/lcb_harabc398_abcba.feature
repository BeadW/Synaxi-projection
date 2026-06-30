Feature: LiveCodeBench/atcoder/hard — ABCBA
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Find one shortest palindrome that has S as its prefix.

      Input

      The input is given from Standard Input in the following format:
      S

      Output

      Print the answer.
      If multiple solutions exist, any of them is accepted.

      Constraints


      - S is a string of length between 1 and 500000, inclusive, consisting of uppercase English letters.

      Sample Input 1

      ABC

      Sample Output 1

      ABCBA

      ABCBA is a shortest palindrome that has S= ABC as its prefix.

      Sample Input 2

      Z

      Sample Output 2

      Z

      Z is a shortest palindrome that has S= Z as its prefix.

      Sample Input 3

      TREE

      Sample Output 3

      TREERT

      TREERT is a shortest palindrome that has S= TREE as its prefix.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "ABC",
              "ABCBA"
          ],
          [
              "Z",
              "Z"
          ],
          [
              "TREE",
              "TREERT"
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
