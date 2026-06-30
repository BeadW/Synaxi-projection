Feature: MBPP/223 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def is_majority(arr, n, x):
          pass

      === test_solution.py ===
      from solution import is_majority


      def test_mbpp():
          assert is_majority([1, 2, 3, 3, 3, 3, 10], 7, 3) == True
          assert is_majority([1, 1, 2, 4, 4, 4, 6, 6], 8, 4) == False
          assert is_majority([1, 1, 1, 2, 2], 5, 1) == True
          assert is_majority([1, 1, 2, 2], 5, 1) == False

      """

  Scenario: Agent implements is_majority so all pytest tests pass
    Given an agent is tasked with implementing the is_majority function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
