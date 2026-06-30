Feature: LiveCodeBench/atcoder/hard — Many LCS
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a lowercase English string S of length N and an integer M. For each k=0,1,\ldots,N, solve the following problem:

      - There are 26^M lowercase English strings of length M. Among these, find the number, modulo 998244353, of strings whose longest common subsequence with S has length exactly k.

      Input

      The input is given from Standard Input in the following format:
      N M
      S

      Output

      Let \mathrm{ans}_i be the answer for k=i. Print the answers in the following format:
      \mathrm{ans}_0 \mathrm{ans}_1 \ldots \mathrm{ans}_N

      Constraints


      - 1\leq N\leq 10
      - 1\leq M\leq 100
      - N and M are integers.
      - S is a lowercase English string of length N.

      Sample Input 1

      2 2
      ab

      Sample Output 1

      576 99 1

      The answers for k=0,1,2 are as follows:

      - For k=0: Among length 2 lowercase English strings, those with a longest common subsequence of length 0 with ab include strings such as cd, re, zz, totaling 576.
      - For k=1: Among length 2 lowercase English strings, those with a longest common subsequence of length 1 with ab include strings such as ac, wa, ba, totaling 99.
      - For k=2: Among length 2 lowercase English strings, there is 1 string (ab) whose longest common subsequence with ab has length 2.

      Sample Input 2

      3 4
      aaa

      Sample Output 2

      390625 62500 3750 101

      Sample Input 3

      7 50
      atcoder

      Sample Output 3

      309810541 226923474 392073062 146769908 221445233 435648037 862664208 238437587

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "2 2\nab",
              "576 99 1"
          ],
          [
              "3 4\naaa",
              "390625 62500 3750 101"
          ],
          [
              "7 50\natcoder",
              "309810541 226923474 392073062 146769908 221445233 435648037 862664208 238437587"
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
