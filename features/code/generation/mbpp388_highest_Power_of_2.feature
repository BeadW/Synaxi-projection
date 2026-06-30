Feature: MBPP/388 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def highest_Power_of_2(n):
          pass

      === test_solution.py ===
      from solution import highest_Power_of_2


      def test_mbpp():
          assert highest_Power_of_2(10) == 8
          assert highest_Power_of_2(19) == 16
          assert highest_Power_of_2(32) == 32

      """

  Scenario: Agent implements highest_Power_of_2 so all pytest tests pass
    Given an agent is tasked with implementing the highest_Power_of_2 function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
