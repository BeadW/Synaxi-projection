Feature: MBPP/59 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def is_octagonal(n):
          pass

      === test_solution.py ===
      from solution import is_octagonal


      def test_mbpp():
          assert is_octagonal(5) == 65
          assert is_octagonal(10) == 280
          assert is_octagonal(15) == 645

      """

  Scenario: Agent implements is_octagonal so all pytest tests pass
    Given an agent is tasked with implementing the is_octagonal function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
