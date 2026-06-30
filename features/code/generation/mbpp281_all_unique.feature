Feature: MBPP/281 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def all_unique(test_list):
          pass

      === test_solution.py ===
      from solution import all_unique


      def test_mbpp():
          assert all_unique([1,2,3]) == True
          assert all_unique([1,2,1,2]) == False
          assert all_unique([1,2,3,4,5]) == True

      """

  Scenario: Agent implements all_unique so all pytest tests pass
    Given an agent is tasked with implementing the all_unique function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
