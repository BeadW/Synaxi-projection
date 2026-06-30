Feature: LiveCodeBench/leetcode/hard — find-the-number-of-possible-ways-for-an-event
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given three integers n, x, and y.
      An event is being held for n performers. When a performer arrives, they are assigned to one of the x stages. All performers assigned to the same stage will perform together as a band, though some stages might remain empty.
      After all performances are completed, the jury will award each band a score in the range [1, y].
      Return the total number of possible ways the event can take place.
      Since the answer may be very large, return it modulo 10^9 + 7.
      Note that two events are considered to have been held differently if either of the following conditions is satisfied:

      Any performer is assigned a different stage.
      Any band is awarded a different score.

 
      Example 1:

      Input: n = 1, x = 2, y = 3
      Output: 6
      Explanation:

      There are 2 ways to assign a stage to the performer.
      The jury can award a score of either 1, 2, or 3 to the only band.


      Example 2:

      Input: n = 5, x = 2, y = 1
      Output: 32
      Explanation:

      Each performer will be assigned either stage 1 or stage 2.
      All bands will be awarded a score of 1.


      Example 3:

      Input: n = 3, x = 3, y = 4
      Output: 684

 
      Constraints:

      1 <= n, x, y <= 1000

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "1\n2\n3",
              "6"
          ],
          [
              "5\n2\n1",
              "32"
          ],
          [
              "3\n3\n4",
              "684"
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
