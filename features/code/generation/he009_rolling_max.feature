Feature: HumanEval/9 — implement rolling_max
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List, Tuple


      def rolling_max(numbers: List[int]) -> List[int]:
          ''' From a given list of integers, generate a list of rolling maximum element found until given moment
          in the sequence.
          >>> rolling_max([1, 2, 3, 2, 3, 4, 2])
          [1, 2, 3, 3, 3, 4, 4]
          '''
          pass

      === test_solution.py ===
      from solution import rolling_max


      def test_humaneval():
          assert rolling_max([]) == []
          assert rolling_max([1, 2, 3, 4]) == [1, 2, 3, 4]
          assert rolling_max([4, 3, 2, 1]) == [4, 4, 4, 4]
          assert rolling_max([3, 2, 3, 100, 3]) == [3, 3, 3, 100, 100]

      """

  Scenario: Agent implements rolling_max so all tests pass
    Given an agent is tasked with implementing the rolling_max function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
