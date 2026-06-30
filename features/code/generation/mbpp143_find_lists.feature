Feature: MBPP/143 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def find_lists(Input):
          pass

      === test_solution.py ===
      from solution import find_lists


      def test_mbpp():
          assert find_lists(([1, 2, 3, 4], [5, 6, 7, 8])) == 2
          assert find_lists(([1, 2], [3, 4], [5, 6]))  == 3
          assert find_lists(([9, 8, 7, 6, 5, 4, 3, 2, 1])) == 1

      """

  Scenario: Agent implements find_lists so all pytest tests pass
    Given an agent is tasked with implementing the find_lists function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
