Feature: MBPP/296 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def get_Inv_Count(arr):
          pass

      === test_solution.py ===
      from solution import get_Inv_Count


      def test_mbpp():
          assert get_Inv_Count([1,20,6,4,5]) == 5
          assert get_Inv_Count([1,2,1]) == 1
          assert get_Inv_Count([1,2,5,6,1]) == 3

      """

  Scenario: Agent implements get_Inv_Count so all pytest tests pass
    Given an agent is tasked with implementing the get_Inv_Count function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
