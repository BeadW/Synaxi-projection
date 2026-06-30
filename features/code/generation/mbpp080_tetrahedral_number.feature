Feature: MBPP/80 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def tetrahedral_number(n):
          pass

      === test_solution.py ===
      from solution import tetrahedral_number


      def test_mbpp():
          assert tetrahedral_number(5) == 35
          assert tetrahedral_number(6) == 56
          assert tetrahedral_number(7) == 84

      """

  Scenario: Agent implements tetrahedral_number so all pytest tests pass
    Given an agent is tasked with implementing the tetrahedral_number function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
