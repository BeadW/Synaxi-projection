Feature: MBPP/58 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def opposite_Signs(x,y):
          pass

      === test_solution.py ===
      from solution import opposite_Signs


      def test_mbpp():
          assert opposite_Signs(1,-2) == True
          assert opposite_Signs(3,2) == False
          assert opposite_Signs(-10,-10) == False
          assert opposite_Signs(-2,2) == True

      """

  Scenario: Agent implements opposite_Signs so all pytest tests pass
    Given an agent is tasked with implementing the opposite_Signs function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
