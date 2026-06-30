Feature: MBPP/119 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def search(arr):
          pass

      === test_solution.py ===
      from solution import search


      def test_mbpp():
          assert search([1,1,2,2,3]) == 3
          assert search([1,1,3,3,4,4,5,5,7,7,8]) == 8
          assert search([1,2,2,3,3,4,4]) == 1

      """

  Scenario: Agent implements search so all pytest tests pass
    Given an agent is tasked with implementing the search function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
