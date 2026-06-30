Feature: LiveCodeBench/leetcode/hard — sorted-gcd-pair-queries
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an integer array nums of length n and an integer array queries.
      Let gcdPairs denote an array obtained by calculating the GCD of all possible pairs (nums[i], nums[j]), where 0 <= i < j < n, and then sorting these values in ascending order.
      For each query queries[i], you need to find the element at index queries[i] in gcdPairs.
      Return an integer array answer, where answer[i] is the value at gcdPairs[queries[i]] for each query.
      The term gcd(a, b) denotes the greatest common divisor of a and b.
 
      Example 1:

      Input: nums = [2,3,4], queries = [0,2,2]
      Output: [1,2,2]
      Explanation:
      gcdPairs = [gcd(nums[0], nums[1]), gcd(nums[0], nums[2]), gcd(nums[1], nums[2])] = [1, 2, 1].
      After sorting in ascending order, gcdPairs = [1, 1, 2].
      So, the answer is [gcdPairs[queries[0]], gcdPairs[queries[1]], gcdPairs[queries[2]]] = [1, 2, 2].

      Example 2:

      Input: nums = [4,4,2,1], queries = [5,3,1,0]
      Output: [4,2,1,1]
      Explanation:
      gcdPairs sorted in ascending order is [1, 1, 1, 2, 2, 4].

      Example 3:

      Input: nums = [2,2], queries = [0,0]
      Output: [2,2]
      Explanation:
      gcdPairs = [2].

 
      Constraints:

      2 <= n == nums.length <= 10^5
      1 <= nums[i] <= 5 * 10^4
      1 <= queries.length <= 10^5
      0 <= queries[i] < n * (n - 1) / 2

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[2, 3, 4]\n[0, 2, 2]",
              "[1, 2, 2]"
          ],
          [
              "[4, 4, 2, 1]\n[5, 3, 1, 0]",
              "[4, 2, 1, 1]"
          ],
          [
              "[2, 2]\n[0, 0]",
              "[2, 2]"
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
