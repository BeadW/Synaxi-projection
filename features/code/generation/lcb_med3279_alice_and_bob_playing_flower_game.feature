Feature: LiveCodeBench/leetcode/medium — alice-and-bob-playing-flower-game
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Alice and Bob are playing a turn-based game on a circular field surrounded by flowers. The circle represents the field, and there are x flowers in the clockwise direction between Alice and Bob, and y flowers in the anti-clockwise direction between them.
      The game proceeds as follows:

      Alice takes the first turn.
      In each turn, a player must choose either the clockwise or anti-clockwise direction and pick one flower from that side.
      At the end of the turn, if there are no flowers left at all, the current player captures their opponent and wins the game.

      Given two integers, n and m, the task is to compute the number of possible pairs (x, y) that satisfy the conditions:

      Alice must win the game according to the described rules.
      The number of flowers x in the clockwise direction must be in the range [1,n].
      The number of flowers y in the anti-clockwise direction must be in the range [1,m].

      Return the number of possible pairs (x, y) that satisfy the conditions mentioned in the statement.
 
      Example 1:

      Input: n = 3, m = 2
      Output: 3
      Explanation: The following pairs satisfy conditions described in the statement: (1,2), (3,2), (2,1).

      Example 2:

      Input: n = 1, m = 1
      Output: 0
      Explanation: No pairs satisfy the conditions described in the statement.

 
      Constraints:

      1 <= n, m <= 10^5

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n2",
              "3"
          ],
          [
              "1\n1",
              "0"
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
