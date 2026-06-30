Feature: MBPP/123 — 
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def amicable_numbers_sum(limit):
          pass

      === test_solution.py ===
      from solution import amicable_numbers_sum


      def test_mbpp():
          assert amicable_numbers_sum(999)==504
          assert amicable_numbers_sum(9999)==31626
          assert amicable_numbers_sum(99)==0

      """

  Scenario: Agent implements amicable_numbers_sum so all pytest tests pass
    Given an agent is tasked with implementing the amicable_numbers_sum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
