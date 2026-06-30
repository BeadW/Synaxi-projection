Feature: HumanEval/26 — implement remove_duplicates
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List


      def remove_duplicates(numbers: List[int]) -> List[int]:
          ''' From a list of integers, remove all elements that occur more than once.
          Keep order of elements left the same as in the input.
          >>> remove_duplicates([1, 2, 3, 2, 4])
          [1, 3, 4]
          '''
          pass

      === test_solution.py ===
      from solution import remove_duplicates


      def test_humaneval():
          assert remove_duplicates([]) == []
          assert remove_duplicates([1, 2, 3, 4]) == [1, 2, 3, 4]
          assert remove_duplicates([1, 2, 3, 2, 4, 3, 5]) == [1, 4, 5]

      """

  Scenario: Agent implements remove_duplicates so all tests pass
    Given an agent is tasked with implementing the remove_duplicates function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
