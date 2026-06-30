Feature: LiveCodeBench/leetcode/hard — longest-common-prefix-of-k-strings-after-removal
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an array of strings words and an integer k.
      For each index i in the range [0, words.length - 1], find the length of the longest common prefix among any k strings (selected at distinct indices) from the remaining array after removing the i^th element.
      Return an array answer, where answer[i] is the answer for i^th element. If removing the i^th element leaves the array with fewer than k strings, answer[i] is 0.
 
      Example 1:

      Input: words = ["jump","run","run","jump","run"], k = 2
      Output: [3,4,4,3,4]
      Explanation:

      Removing index 0 ("jump"):

	
      words becomes: ["run", "run", "jump", "run"]. "run" occurs 3 times. Choosing any two gives the longest common prefix "run" (length 3).


      Removing index 1 ("run"):
	
      words becomes: ["jump", "run", "jump", "run"]. "jump" occurs twice. Choosing these two gives the longest common prefix "jump" (length 4).


      Removing index 2 ("run"):
	
      words becomes: ["jump", "run", "jump", "run"]. "jump" occurs twice. Choosing these two gives the longest common prefix "jump" (length 4).


      Removing index 3 ("jump"):
	
      words becomes: ["jump", "run", "run", "run"]. "run" occurs 3 times. Choosing any two gives the longest common prefix "run" (length 3).


      Removing index 4 ("run"):
	
      words becomes: ["jump", "run", "run", "jump"]. "jump" occurs twice. Choosing these two gives the longest common prefix "jump" (length 4).




      Example 2:

      Input: words = ["dog","racer","car"], k = 2
      Output: [0,0,0]
      Explanation:

      Removing any index results in an answer of 0.


 
      Constraints:

      1 <= k <= words.length <= 10^5
      1 <= words[i].length <= 10^4
      words[i] consists of lowercase English letters.
      The sum of words[i].length is smaller than or equal 10^5.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[\"jump\", \"run\", \"run\", \"jump\", \"run\"]\n2",
              "[3, 4, 4, 3, 4]"
          ],
          [
              "[\"dog\", \"racer\", \"car\"]\n2",
              "[0, 0, 0]"
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
