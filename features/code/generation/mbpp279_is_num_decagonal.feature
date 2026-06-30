Feature: MBPP/279 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def is_num_decagonal(n):
          pass

      === test_solution.py ===
      from solution import is_num_decagonal


      def test_mbpp():
          assert is_num_decagonal(3) == 27
          assert is_num_decagonal(7) == 175
          assert is_num_decagonal(10) == 370

      """

  Scenario: Agent implements is_num_decagonal so all pytest tests pass
    Given an agent is tasked with implementing the is_num_decagonal function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
