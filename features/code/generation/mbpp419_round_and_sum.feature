Feature: MBPP/419 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def round_and_sum(list1):
          pass

      === test_solution.py ===
      from solution import round_and_sum


      def test_mbpp():
          assert round_and_sum([22.4, 4.0, -16.22, -9.10, 11.00, -12.22, 14.20, -5.20, 17.50])==243
          assert round_and_sum([5,2,9,24.3,29])==345
          assert round_and_sum([25.0,56.7,89.2])==513

      """

  Scenario: Agent implements round_and_sum so all pytest tests pass
    Given an agent is tasked with implementing the round_and_sum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
