Feature: LiveCodeBench/atcoder/hard — 11/22 Subsequence
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      The definition of an 11/22 string in this problem is the same as in Problems A and C.

      A string T is called an 11/22 string when it satisfies all of the following conditions:

      - |T| is odd. Here, |T| denotes the length of T.
      - The 1-st through (\frac{|T|+1}{2} - 1)-th characters are all 1.
      - The (\frac{|T|+1}{2})-th character is /.
      - The (\frac{|T|+1}{2} + 1)-th through |T|-th characters are all 2.

      For example, 11/22, 111/222, and / are 11/22 strings, but 1122, 1/22, 11/2222, 22/11, and //2/2/211 are not.
      Given a string S of length N consisting of 1, 2, and /, process Q queries.
      Each query provides two integers L and R. Let T be the (contiguous) substring of S from the L-th through R-th character. Find the maximum length of a subsequence (not necessarily contiguous) of T that is an 11/22 string. If no such subsequence exists, print 0.

      Input

      The input is given from Standard Input in the following format. Here, \mathrm{query}_i denotes the i-th query.
      N Q
      S
      \mathrm{query}_1
      \mathrm{query}_2
      \vdots
      \mathrm{query}_Q

      Each query is given in the following format:
      L R

      Output

      Print Q lines. The i-th line should contain the answer to the i-th query.

      Constraints


      - 1 \leq N \leq 10^5
      - 1 \leq Q \leq 10^5
      - S is a string of length N consisting of 1, 2, and /.
      - 1 \leq L \leq R \leq N
      - N, Q, L, and R are integers.

      Sample Input 1

      12 5
      111/212/1122
      1 7
      9 12
      3 6
      4 10
      1 12

      Sample Output 1

      5
      0
      3
      1
      7

      For the first query, the substring from the 1-st to 7-th character of S is 111/212. This string contains 11/22 as a subsequence, which is the longest subsequence that is an 11/22 string. Therefore, the answer is 5.
      For the second query, the substring from the 9-th to 12-th character of S is 1122. This string does not contain any subsequence that is an 11/22 string, so the answer is 0.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "12 5\n111/212/1122\n1 7\n9 12\n3 6\n4 10\n1 12",
              "5\n0\n3\n1\n7"
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
