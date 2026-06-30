Feature: LiveCodeBench/leetcode/hard — minimum-operations-to-make-character-frequencies-equal
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a string s.
      A string t is called good if all characters of t occur the same number of times.
      You can perform the following operations any number of times:

      Delete a character from s.
      Insert a character in s.
      Change a character in s to its next letter in the alphabet.

      Note that you cannot change 'z' to 'a' using the third operation.
      Return the minimum number of operations required to make s good.
 
      Example 1:

      Input: s = "acab"
      Output: 1
      Explanation:
      We can make s good by deleting one occurrence of character 'a'.

      Example 2:

      Input: s = "wddw"
      Output: 0
      Explanation:
      We do not need to perform any operations since s is initially good.

      Example 3:

      Input: s = "aaabc"
      Output: 2
      Explanation:
      We can make s good by applying these operations:

      Change one occurrence of 'a' to 'b'
      Insert one occurrence of 'c' into s


 
      Constraints:

      3 <= s.length <= 2 * 10^4
      s contains only lowercase English letters.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "\"acab\"",
              "1"
          ],
          [
              "\"wddw\"",
              "0"
          ],
          [
              "\"aaabc\"",
              "2"
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
