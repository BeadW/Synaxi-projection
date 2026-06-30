Feature: LiveCodeBench/leetcode/hard — construct-string-with-minimum-cost
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a string target, an array of strings words, and an integer array costs, both arrays of the same length.
      Imagine an empty string s.
      You can perform the following operation any number of times (including zero):

      Choose an index i in the range [0, words.length - 1].
      Append words[i] to s.
      The cost of operation is costs[i].

      Return the minimum cost to make s equal to target. If it's not possible, return -1.
 
      Example 1:

      Input: target = "abcdef", words = ["abdef","abc","d","def","ef"], costs = [100,1,1,10,5]
      Output: 7
      Explanation:
      The minimum cost can be achieved by performing the following operations:

      Select index 1 and append "abc" to s at a cost of 1, resulting in s = "abc".
      Select index 2 and append "d" to s at a cost of 1, resulting in s = "abcd".
      Select index 4 and append "ef" to s at a cost of 5, resulting in s = "abcdef".


      Example 2:

      Input: target = "aaaa", words = ["z","zz","zzz"], costs = [1,10,100]
      Output: -1
      Explanation:
      It is impossible to make s equal to target, so we return -1.

 
      Constraints:

      1 <= target.length <= 5 * 10^4
      1 <= words.length == costs.length <= 5 * 10^4
      1 <= words[i].length <= target.length
      The total sum of words[i].length is less than or equal to 5 * 10^4.
      target and words[i] consist only of lowercase English letters.
      1 <= costs[i] <= 10^4

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "\"abcdef\"\n[\"abdef\", \"abc\", \"d\", \"def\", \"ef\"]\n[100, 1, 1, 10, 5]",
              "7"
          ],
          [
              "\"aaaa\"\n[\"z\", \"zz\", \"zzz\"]\n[1, 10, 100]",
              "-1"
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
