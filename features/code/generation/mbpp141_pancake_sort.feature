Feature: MBPP/141 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def pancake_sort(nums):
          pass

      === test_solution.py ===
      from solution import pancake_sort


      def test_mbpp():
          assert pancake_sort([15, 79, 25, 38, 69]) == [15, 25, 38, 69, 79]
          assert pancake_sort([98, 12, 54, 36, 85]) == [12, 36, 54, 85, 98]
          assert pancake_sort([41, 42, 32, 12, 23]) == [12, 23, 32, 41, 42]

      """

  Scenario: Agent implements pancake_sort so all pytest tests pass
    Given an agent is tasked with implementing the pancake_sort function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
