Feature: HumanEval/0 — implement has_close_elements
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List


      def has_close_elements(numbers: List[float], threshold: float) -> bool:
          ''' Check if in given list of numbers, are any two numbers closer to each other than
          given threshold.
          >>> has_close_elements([1.0, 2.0, 3.0], 0.5)
          False
          >>> has_close_elements([1.0, 2.8, 3.0, 4.0, 5.0, 2.0], 0.3)
          True
          '''
          pass

      === test_solution.py ===
      from solution import has_close_elements


      def test_humaneval():
          assert has_close_elements([1.0, 2.0, 3.9, 4.0, 5.0, 2.2], 0.3) == True
          assert has_close_elements([1.0, 2.0, 3.9, 4.0, 5.0, 2.2], 0.05) == False
          assert has_close_elements([1.0, 2.0, 5.9, 4.0, 5.0], 0.95) == True
          assert has_close_elements([1.0, 2.0, 5.9, 4.0, 5.0], 0.8) == False
          assert has_close_elements([1.0, 2.0, 3.0, 4.0, 5.0, 2.0], 0.1) == True
          assert has_close_elements([1.1, 2.2, 3.1, 4.1, 5.1], 1.0) == True
          assert has_close_elements([1.1, 2.2, 3.1, 4.1, 5.1], 0.5) == False


      """

  Scenario: Agent implements has_close_elements so all tests pass
    Given an agent is tasked with implementing the has_close_elements function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
