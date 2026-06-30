Feature: MBPP/89 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def closest_num(N):
          pass

      === test_solution.py ===
      from solution import closest_num


      def test_mbpp():
          assert closest_num(11) == 10
          assert closest_num(7) == 6
          assert closest_num(12) == 11

      """

  Scenario: Agent implements closest_num so all pytest tests pass
    Given an agent is tasked with implementing the closest_num function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
