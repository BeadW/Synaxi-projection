Feature: LiveCodeBench/leetcode/hard — minimum-amount-of-damage-dealt-to-bob
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an integer power and two integer arrays damage and health, both having length n.
      Bob has n enemies, where enemy i will deal Bob damage[i] points of damage per second while they are alive (i.e. health[i] > 0).
      Every second, after the enemies deal damage to Bob, he chooses one of the enemies that is still alive and deals power points of damage to them.
      Determine the minimum total amount of damage points that will be dealt to Bob before all n enemies are dead.
 
      Example 1:

      Input: power = 4, damage = [1,2,3,4], health = [4,5,6,8]
      Output: 39
      Explanation:

      Attack enemy 3 in the first two seconds, after which enemy 3 will go down, the number of damage points dealt to Bob is 10 + 10 = 20 points.
      Attack enemy 2 in the next two seconds, after which enemy 2 will go down, the number of damage points dealt to Bob is 6 + 6 = 12 points.
      Attack enemy 0 in the next second, after which enemy 0 will go down, the number of damage points dealt to Bob is 3 points.
      Attack enemy 1 in the next two seconds, after which enemy 1 will go down, the number of damage points dealt to Bob is 2 + 2 = 4 points.


      Example 2:

      Input: power = 1, damage = [1,1,1,1], health = [1,2,3,4]
      Output: 20
      Explanation:

      Attack enemy 0 in the first second, after which enemy 0 will go down, the number of damage points dealt to Bob is 4 points.
      Attack enemy 1 in the next two seconds, after which enemy 1 will go down, the number of damage points dealt to Bob is 3 + 3 = 6 points.
      Attack enemy 2 in the next three seconds, after which enemy 2 will go down, the number of damage points dealt to Bob is 2 + 2 + 2 = 6 points.
      Attack enemy 3 in the next four seconds, after which enemy 3 will go down, the number of damage points dealt to Bob is 1 + 1 + 1 + 1 = 4 points.


      Example 3:

      Input: power = 8, damage = [40], health = [59]
      Output: 320

 
      Constraints:

      1 <= power <= 10^4
      1 <= n == damage.length == health.length <= 10^5
      1 <= damage[i], health[i] <= 10^4

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "4\n[1, 2, 3, 4]\n[4, 5, 6, 8]",
              "39"
          ],
          [
              "1\n[1, 1, 1, 1]\n[1, 2, 3, 4]",
              "20"
          ],
          [
              "8\n[40]\n[59]",
              "320"
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
