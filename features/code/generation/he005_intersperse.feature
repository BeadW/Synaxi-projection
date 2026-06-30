Feature: HumanEval/5 — implement intersperse
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List


      def intersperse(numbers: List[int], delimeter: int) -> List[int]:
          ''' Insert a number 'delimeter' between every two consecutive elements of input list `numbers'
          >>> intersperse([], 4)
          []
          >>> intersperse([1, 2, 3], 4)
          [1, 4, 2, 4, 3]
          '''
          pass

      === test_solution.py ===
      from solution import intersperse


      def test_humaneval():
          assert intersperse([], 7) == []
          assert intersperse([5, 6, 3, 2], 8) == [5, 8, 6, 8, 3, 8, 2]
          assert intersperse([2, 2, 2], 2) == [2, 2, 2, 2, 2]

      """

  Scenario: Agent implements intersperse so all tests pass
    Given an agent is tasked with implementing the intersperse function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
