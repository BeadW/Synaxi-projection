Feature: LiveCodeBench/leetcode/hard — smallest-substring-with-identical-characters-i
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a binary string s of length n and an integer numOps.
      You are allowed to perform the following operation on s at most numOps times:

      Select any index i (where 0 <= i < n) and flip s[i]. If s[i] == '1', change s[i] to '0' and vice versa.

      You need to minimize the length of the longest substring of s such that all the characters in the substring are identical.
      Return the minimum length after the operations.
 
      Example 1:

      Input: s = "000001", numOps = 1
      Output: 2
      Explanation: 
      By changing s[2] to '1', s becomes "001001". The longest substrings with identical characters are s[0..1] and s[3..4].

      Example 2:

      Input: s = "0000", numOps = 2
      Output: 1
      Explanation: 
      By changing s[0] and s[2] to '1', s becomes "1010".

      Example 3:

      Input: s = "0101", numOps = 0
      Output: 1

 
      Constraints:

      1 <= n == s.length <= 1000
      s consists only of '0' and '1'.
      0 <= numOps <= n

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "\"000001\"\n1",
              "2"
          ],
          [
              "\"0000\"\n2",
              "1"
          ],
          [
              "\"0101\"\n0",
              "1"
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
