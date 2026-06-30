Feature: MBPP/311 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def set_left_most_unset_bit(n):
          pass

      === test_solution.py ===
      from solution import set_left_most_unset_bit


      def test_mbpp():
          assert set_left_most_unset_bit(10) == 14
          assert set_left_most_unset_bit(12) == 14
          assert set_left_most_unset_bit(15) == 15

      """

  Scenario: Agent implements set_left_most_unset_bit so all pytest tests pass
    Given an agent is tasked with implementing the set_left_most_unset_bit function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
