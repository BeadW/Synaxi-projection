Feature: HumanEval/20 — implement find_closest_elements
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List, Tuple


      def find_closest_elements(numbers: List[float]) -> Tuple[float, float]:
          ''' From a supplied list of numbers (of length at least two) select and return two that are the closest to each
          other and return them in order (smaller number, larger number).
          >>> find_closest_elements([1.0, 2.0, 3.0, 4.0, 5.0, 2.2])
          (2.0, 2.2)
          >>> find_closest_elements([1.0, 2.0, 3.0, 4.0, 5.0, 2.0])
          (2.0, 2.0)
          '''
          pass

      === test_solution.py ===
      from solution import find_closest_elements


      def test_humaneval():
          assert find_closest_elements([1.0, 2.0, 3.9, 4.0, 5.0, 2.2]) == (3.9, 4.0)
          assert find_closest_elements([1.0, 2.0, 5.9, 4.0, 5.0]) == (5.0, 5.9)
          assert find_closest_elements([1.0, 2.0, 3.0, 4.0, 5.0, 2.2]) == (2.0, 2.2)
          assert find_closest_elements([1.0, 2.0, 3.0, 4.0, 5.0, 2.0]) == (2.0, 2.0)
          assert find_closest_elements([1.1, 2.2, 3.1, 4.1, 5.1]) == (2.2, 3.1)


      """

  Scenario: Agent implements find_closest_elements so all tests pass
    Given an agent is tasked with implementing the find_closest_elements function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
