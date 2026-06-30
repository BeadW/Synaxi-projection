Feature: MBPP/164 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def div_sum():
          pass

      === test_solution.py ===
      from solution import div_sum


      def test_mbpp():
          assert are_equivalent(36, 57) == False
          assert are_equivalent(2, 4) == False
          assert are_equivalent(23, 47) == True

      """

  Scenario: Agent implements div_sum so all pytest tests pass
    Given an agent is tasked with implementing the div_sum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
