Feature: LiveCodeBench/atcoder/hard — Avoid K Palindrome
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a string S of length N consisting of characters A, B, and ?.
      You are also given a positive integer K.
      A string T consisting of A and B is considered a good string if it satisfies the following condition:

      - No contiguous substring of length K in T is a palindrome.

      Let q be the number of ? characters in S.
      There are 2^q strings that can be obtained by replacing each ? in S with either A or B. Find how many of these strings are good strings.
      The count can be very large, so find it modulo 998244353.

      Input

      The input is given from Standard Input in the following format:
      N K
      S

      Output

      Print the answer.

      Constraints


      - 2 \leq K \leq N \leq 1000
      - K \leq 10
      - S is a string consisting of A, B, and ?.
      - The length of S is N.
      - N and K are integers.

      Sample Input 1

      7 4
      AB?A?BA

      Sample Output 1

      1

      The given string has two ?s.
      There are four strings obtained by replacing each ? with A or B:

      - ABAAABA
      - ABAABBA
      - ABBAABA
      - ABBABBA

      Among these, the last three contain the contiguous substring ABBA of length 4, which is a palindrome, and thus are not good strings.
      Therefore, you should print 1.

      Sample Input 2

      40 7
      ????????????????????????????????????????

      Sample Output 2

      116295436

      Ensure to find the number of good strings modulo 998244353.

      Sample Input 3

      15 5
      ABABA??????????

      Sample Output 3

      0

      It is possible that there is no way to replace the ?s to obtain a good string.

      Sample Input 4

      40 8
      ?A?B??B?B?AA?A?B??B?A???B?BB?B???BA??BAA

      Sample Output 4

      259240

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "7 4\nAB?A?BA\n",
              "1\n"
          ],
          [
              "40 7\n????????????????????????????????????????\n",
              "116295436\n"
          ],
          [
              "15 5\nABABA??????????\n",
              "0\n"
          ],
          [
              "40 8\n?A?B??B?B?AA?A?B??B?A???B?BB?B???BA??BAA\n",
              "259240\n"
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
