Feature: LiveCodeBench/leetcode/hard — kth-smallest-amount-with-single-denomination-combination
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an integer array coins representing coins of different denominations and an integer k.
      You have an infinite number of coins of each denomination. However, you are not allowed to combine coins of different denominations.
      Return the k^th smallest amount that can be made using these coins.
 
      Example 1:

      Input: coins = [3,6,9], k = 3
      Output:  9
      Explanation: The given coins can make the following amounts:
      Coin 3 produces multiples of 3: 3, 6, 9, 12, 15, etc.
      Coin 6 produces multiples of 6: 6, 12, 18, 24, etc.
      Coin 9 produces multiples of 9: 9, 18, 27, 36, etc.
      All of the coins combined produce: 3, 6, 9, 12, 15, etc.

      Example 2:

      Input: coins = [5,2], k = 7
      Output: 12 
      Explanation: The given coins can make the following amounts:
      Coin 5 produces multiples of 5: 5, 10, 15, 20, etc.
      Coin 2 produces multiples of 2: 2, 4, 6, 8, 10, 12, etc.
      All of the coins combined produce: 2, 4, 5, 6, 8, 10, 12, 14, 15, etc.

 
      Constraints:

      1 <= coins.length <= 15
      1 <= coins[i] <= 25
      1 <= k <= 2 * 10^9
      coins contains pairwise distinct integers.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[3, 6, 9]\n3",
              "9"
          ],
          [
              "[5, 2]\n7",
              "12"
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
