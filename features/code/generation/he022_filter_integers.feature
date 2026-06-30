Feature: HumanEval/22 — implement filter_integers
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List, Any


      def filter_integers(values: List[Any]) -> List[int]:
          ''' Filter given list of any python values only for integers
          >>> filter_integers(['a', 3.14, 5])
          [5]
          >>> filter_integers([1, 2, 3, 'abc', {}, []])
          [1, 2, 3]
          '''
          pass

      === test_solution.py ===
      from solution import filter_integers


      def test_humaneval():
          assert filter_integers([]) == []
          assert filter_integers([4, {}, [], 23.2, 9, 'adasd']) == [4, 9]
          assert filter_integers([3, 'c', 3, 3, 'a', 'b']) == [3, 3, 3]

      """

  Scenario: Agent implements filter_integers so all tests pass
    Given an agent is tasked with implementing the filter_integers function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
