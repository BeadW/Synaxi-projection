Feature: LiveCodeBench/leetcode/hard — permutations-iv
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Given two integers, n and k, an alternating permutation is a permutation of the first n positive integers such that no two adjacent elements are both odd or both even.
      Return the k-th alternating permutation sorted in lexicographical order. If there are fewer than k valid alternating permutations, return an empty list.
 
      Example 1:

      Input: n = 4, k = 6
      Output: [3,4,1,2]
      Explanation:
      The lexicographically-sorted alternating permutations of [1, 2, 3, 4] are:

      [1, 2, 3, 4]
      [1, 4, 3, 2]
      [2, 1, 4, 3]
      [2, 3, 4, 1]
      [3, 2, 1, 4]
      [3, 4, 1, 2] ← 6th permutation
      [4, 1, 2, 3]
      [4, 3, 2, 1]

      Since k = 6, we return [3, 4, 1, 2].

      Example 2:

      Input: n = 3, k = 2
      Output: [3,2,1]
      Explanation:
      The lexicographically-sorted alternating permutations of [1, 2, 3] are:

      [1, 2, 3]
      [3, 2, 1] ← 2nd permutation

      Since k = 2, we return [3, 2, 1].

      Example 3:

      Input: n = 2, k = 3
      Output: []
      Explanation:
      The lexicographically-sorted alternating permutations of [1, 2] are:

      [1, 2]
      [2, 1]

      There are only 2 alternating permutations, but k = 3, which is out of range. Thus, we return an empty list [].

 
      Constraints:

      1 <= n <= 100
      1 <= k <= 10^15

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "4\n6",
              "[3, 4, 1, 2]"
          ],
          [
              "3\n2",
              "[3, 2, 1]"
          ],
          [
              "2\n3",
              "[]"
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
