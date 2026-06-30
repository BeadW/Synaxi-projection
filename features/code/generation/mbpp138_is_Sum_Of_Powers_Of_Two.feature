Feature: MBPP/138 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def is_Sum_Of_Powers_Of_Two(n):
          pass

      === test_solution.py ===
      from solution import is_Sum_Of_Powers_Of_Two


      def test_mbpp():
          assert is_Sum_Of_Powers_Of_Two(10) == True
          assert is_Sum_Of_Powers_Of_Two(7) == False
          assert is_Sum_Of_Powers_Of_Two(14) == True

      """

  Scenario: Agent implements is_Sum_Of_Powers_Of_Two so all pytest tests pass
    Given an agent is tasked with implementing the is_Sum_Of_Powers_Of_Two function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
