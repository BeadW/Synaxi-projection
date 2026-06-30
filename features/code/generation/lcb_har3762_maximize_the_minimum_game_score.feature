Feature: LiveCodeBench/leetcode/hard — maximize-the-minimum-game-score
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an array points of size n and an integer m. There is another array gameScore of size n, where gameScore[i] represents the score achieved at the i^th game. Initially, gameScore[i] == 0 for all i.
      You start at index -1, which is outside the array (before the first position at index 0). You can make at most m moves. In each move, you can either:

      Increase the index by 1 and add points[i] to gameScore[i].
      Decrease the index by 1 and add points[i] to gameScore[i].

      Note that the index must always remain within the bounds of the array after the first move.
      Return the maximum possible minimum value in gameScore after at most m moves.
 
      Example 1:

      Input: points = [2,4], m = 3
      Output: 4
      Explanation:
      Initially, index i = -1 and gameScore = [0, 0].



      Move
      Index
      gameScore




      Increase i
      0
      [2, 0]


      Increase i
      1
      [2, 4]


      Decrease i
      0
      [4, 4]



      The minimum value in gameScore is 4, and this is the maximum possible minimum among all configurations. Hence, 4 is the output.

      Example 2:

      Input: points = [1,2,3], m = 5
      Output: 2
      Explanation:
      Initially, index i = -1 and gameScore = [0, 0, 0].



      Move
      Index
      gameScore




      Increase i
      0
      [1, 0, 0]


      Increase i
      1
      [1, 2, 0]


      Decrease i
      0
      [2, 2, 0]


      Increase i
      1
      [2, 4, 0]


      Increase i
      2
      [2, 4, 3]



      The minimum value in gameScore is 2, and this is the maximum possible minimum among all configurations. Hence, 2 is the output.

 
      Constraints:

      2 <= n == points.length <= 5 * 10^4
      1 <= points[i] <= 10^6
      1 <= m <= 10^9

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[2, 4]\n3",
              "4"
          ],
          [
              "[1, 2, 3]\n5",
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
