Feature: HumanEval/21 — implement rescale_to_unit
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List


      def rescale_to_unit(numbers: List[float]) -> List[float]:
          ''' Given list of numbers (of at least two elements), apply a linear transform to that list,
          such that the smallest number will become 0 and the largest will become 1
          >>> rescale_to_unit([1.0, 2.0, 3.0, 4.0, 5.0])
          [0.0, 0.25, 0.5, 0.75, 1.0]
          '''
          pass

      === test_solution.py ===
      from solution import rescale_to_unit


      def test_humaneval():
          assert rescale_to_unit([2.0, 49.9]) == [0.0, 1.0]
          assert rescale_to_unit([100.0, 49.9]) == [1.0, 0.0]
          assert rescale_to_unit([1.0, 2.0, 3.0, 4.0, 5.0]) == [0.0, 0.25, 0.5, 0.75, 1.0]
          assert rescale_to_unit([2.0, 1.0, 5.0, 3.0, 4.0]) == [0.25, 0.0, 1.0, 0.5, 0.75]
          assert rescale_to_unit([12.0, 11.0, 15.0, 13.0, 14.0]) == [0.25, 0.0, 1.0, 0.5, 0.75]

      """

  Scenario: Agent implements rescale_to_unit so all tests pass
    Given an agent is tasked with implementing the rescale_to_unit function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
