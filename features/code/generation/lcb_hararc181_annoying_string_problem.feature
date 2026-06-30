Feature: LiveCodeBench/atcoder/hard — Annoying String Problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      For strings S and T consisting of lowercase English letters, and a string X consisting of 0 and 1, define the string f(S,T,X) consisting of lowercase English letters as follows:

      - Starting with an empty string, for each i=1,2,\dots,|X|, append S to the end if the i-th character of X is 0, and append T to the end if it is 1.

      You are given a string S consisting of lowercase English letters, and strings X and Y consisting of 0 and 1.
      Determine if there exists a string T (which can be empty) such that f(S,T,X)=f(S,T,Y).
      You have t test cases to solve.

      Input

      The input is given from Standard Input in the following format:
      t
      \mathrm{case}_1
      \vdots
      \mathrm{case}_t

      Each case is given in the following format:
      S
      X
      Y

      Output

      Print t lines. The i-th line should contain Yes if there exists a T that satisfies the condition for the i-th test case, and No otherwise.

      Constraints


      - 1 \leq t \leq 5 \times 10^5
      - 1 \leq |S| \leq 5\times 10^5
      - 1 \leq |X|,|Y| \leq 5\times 10^5
      - S is a string consisting of lowercase English letters.
      - X and Y are strings consisting of 0 and 1.
      - The sum of |S| across all test cases in a single input is at most 5 \times 10^5.
      - The sum of |X| across all test cases in a single input is at most 5 \times 10^5.
      - The sum of |Y| across all test cases in a single input is at most 5 \times 10^5.

      Sample Input 1

      3
      araara
      01
      111
      araaaa
      100100
      0010111
      abacabac
      0
      1111

      Sample Output 1

      Yes
      No
      No

      Below, string concatenation is represented using +.
      For the 1st test case, if T=ara, then f(S,T,X)=S+T=araaraara and f(S,T,Y)=T+T+T=araaraara, so f(S,T,X)=f(S,T,Y).
      For the 2nd and 3rd test cases, there is no T that satisfies the condition.

      Sample Input 2

      2
      empty
      10101
      00
      empty
      11111
      111

      Sample Output 2

      Yes
      Yes

      T can be empty.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\naraara\n01\n111\naraaaa\n100100\n0010111\nabacabac\n0\n1111\n",
              "Yes\nNo\nNo\n"
          ],
          [
              "2\nempty\n10101\n00\nempty\n11111\n111\n",
              "Yes\nYes\n"
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
