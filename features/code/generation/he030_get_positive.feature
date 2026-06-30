Feature: HumanEval/30 — implement get_positive
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def get_positive(l: list):
          '''Return only positive numbers in the list.
          >>> get_positive([-1, 2, -4, 5, 6])
          [2, 5, 6]
          >>> get_positive([5, 3, -5, 2, -3, 3, 9, 0, 123, 1, -10])
          [5, 3, 2, 3, 9, 123, 1]
          '''
          pass

      === test_solution.py ===
      from solution import get_positive


      def test_humaneval():
          assert get_positive([-1, -2, 4, 5, 6]) == [4, 5, 6]
          assert get_positive([5, 3, -5, 2, 3, 3, 9, 0, 123, 1, -10]) == [5, 3, 2, 3, 3, 9, 123, 1]
          assert get_positive([-1, -2]) == []
          assert get_positive([]) == []


      """

  Scenario: Agent implements get_positive so all tests pass
    Given an agent is tasked with implementing the get_positive function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
