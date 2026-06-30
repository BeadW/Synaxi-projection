Feature: LiveCodeBench/leetcode/hard — count-the-number-of-arrays-with-k-matching-adjacent-elements
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given three integers n, m, k. A good array arr of size n is defined as follows:

      Each element in arr is in the inclusive range [1, m].
      Exactly k indices i (where 1 <= i < n) satisfy the condition arr[i - 1] == arr[i].

      Return the number of good arrays that can be formed.
      Since the answer may be very large, return it modulo 10^9 + 7.
 
      Example 1:

      Input: n = 3, m = 2, k = 1
      Output: 4
      Explanation:

      There are 4 good arrays. They are [1, 1, 2], [1, 2, 2], [2, 1, 1] and [2, 2, 1].
      Hence, the answer is 4.


      Example 2:

      Input: n = 4, m = 2, k = 2
      Output: 6
      Explanation:

      The good arrays are [1, 1, 1, 2], [1, 1, 2, 2], [1, 2, 2, 2], [2, 1, 1, 1], [2, 2, 1, 1] and [2, 2, 2, 1].
      Hence, the answer is 6.


      Example 3:

      Input: n = 5, m = 2, k = 0
      Output: 2
      Explanation:

      The good arrays are [1, 2, 1, 2, 1] and [2, 1, 2, 1, 2]. Hence, the answer is 2.


 
      Constraints:

      1 <= n <= 10^5
      1 <= m <= 10^5
      0 <= k <= n - 1

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n2\n1",
              "4"
          ],
          [
              "4\n2\n2",
              "6"
          ],
          [
              "5\n2\n0",
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
