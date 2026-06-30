Feature: MBPP/433 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def check_greater(arr, number):
          pass

      === test_solution.py ===
      from solution import check_greater


      def test_mbpp():
          assert check_greater([1, 2, 3, 4, 5], 4) == False
          assert check_greater([2, 3, 4, 5, 6], 8) == True
          assert check_greater([9, 7, 4, 8, 6, 1], 11) == True

      """

  Scenario: Agent implements check_greater so all pytest tests pass
    Given an agent is tasked with implementing the check_greater function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
