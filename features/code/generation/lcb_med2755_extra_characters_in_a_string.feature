Feature: LiveCodeBench/leetcode/medium — extra-characters-in-a-string
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a 0-indexed string s and a dictionary of words dictionary. You have to break s into one or more non-overlapping substrings such that each substring is present in dictionary. There may be some extra characters in s which are not present in any of the substrings.
      Return the minimum number of extra characters left over if you break up s optimally.
 
      Example 1:

      Input: s = "leetscode", dictionary = ["leet","code","leetcode"]
      Output: 1
      Explanation: We can break s in two substrings: "leet" from index 0 to 3 and "code" from index 5 to 8. There is only 1 unused character (at index 4), so we return 1.


      Example 2:

      Input: s = "sayhelloworld", dictionary = ["hello","world"]
      Output: 3
      Explanation: We can break s in two substrings: "hello" from index 3 to 7 and "world" from index 8 to 12. The characters at indices 0, 1, 2 are not used in any substring and thus are considered as extra characters. Hence, we return 3.

 
      Constraints:

      1 <= s.length <= 50
      1 <= dictionary.length <= 50
      1 <= dictionary[i].length <= 50
      dictionary[i] and s consists of only lowercase English letters
      dictionary contains distinct words

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "\"leetscode\"\n[\"leet\", \"code\", \"leetcode\"]",
              "1"
          ],
          [
              "\"sayhelloworld\"\n[\"hello\", \"world\"]",
              "3"
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
