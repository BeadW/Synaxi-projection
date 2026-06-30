Feature: MBPP/226 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def odd_values_string(str):
          pass

      === test_solution.py ===
      from solution import odd_values_string


      def test_mbpp():
          assert odd_values_string('abcdef') == 'ace'
          assert odd_values_string('python') == 'pto'
          assert odd_values_string('data') == 'dt'
          assert odd_values_string('lambs') == 'lms'

      """

  Scenario: Agent implements odd_values_string so all pytest tests pass
    Given an agent is tasked with implementing the odd_values_string function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
