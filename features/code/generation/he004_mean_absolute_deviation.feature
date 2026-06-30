Feature: HumanEval/4 — implement mean_absolute_deviation
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List


      def mean_absolute_deviation(numbers: List[float]) -> float:
          ''' For a given list of input numbers, calculate Mean Absolute Deviation
          around the mean of this dataset.
          Mean Absolute Deviation is the average absolute difference between each
          element and a centerpoint (mean in this case):
          MAD = average | x - x_mean |
          >>> mean_absolute_deviation([1.0, 2.0, 3.0, 4.0])
          1.0
          '''
          pass

      === test_solution.py ===
      from solution import mean_absolute_deviation


      def test_humaneval():
          assert abs(mean_absolute_deviation([1.0, 2.0, 3.0]) - 2.0/3.0) < 1e-6
          assert abs(mean_absolute_deviation([1.0, 2.0, 3.0, 4.0]) - 1.0) < 1e-6
          assert abs(mean_absolute_deviation([1.0, 2.0, 3.0, 4.0, 5.0]) - 6.0/5.0) < 1e-6


      """

  Scenario: Agent implements mean_absolute_deviation so all tests pass
    Given an agent is tasked with implementing the mean_absolute_deviation function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
