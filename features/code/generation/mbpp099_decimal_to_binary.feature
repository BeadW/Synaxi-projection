Feature: MBPP/99 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def decimal_to_binary(n):
          pass

      === test_solution.py ===
      from solution import decimal_to_binary


      def test_mbpp():
          assert decimal_to_binary(8) == '1000'
          assert decimal_to_binary(18) == '10010'
          assert decimal_to_binary(7) == '111'

      """

  Scenario: Agent implements decimal_to_binary so all pytest tests pass
    Given an agent is tasked with implementing the decimal_to_binary function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
