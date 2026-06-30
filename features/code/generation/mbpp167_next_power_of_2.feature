Feature: MBPP/167 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def next_power_of_2(n):
          pass

      === test_solution.py ===
      from solution import next_power_of_2


      def test_mbpp():
          assert next_power_of_2(0) == 1
          assert next_power_of_2(5) == 8
          assert next_power_of_2(17) == 32

      """

  Scenario: Agent implements next_power_of_2 so all pytest tests pass
    Given an agent is tasked with implementing the next_power_of_2 function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
