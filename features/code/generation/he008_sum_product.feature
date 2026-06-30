Feature: HumanEval/8 — implement sum_product
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List, Tuple


      def sum_product(numbers: List[int]) -> Tuple[int, int]:
          ''' For a given list of integers, return a tuple consisting of a sum and a product of all the integers in a list.
          Empty sum should be equal to 0 and empty product should be equal to 1.
          >>> sum_product([])
          (0, 1)
          >>> sum_product([1, 2, 3, 4])
          (10, 24)
          '''
          pass

      === test_solution.py ===
      from solution import sum_product


      def test_humaneval():
          assert sum_product([]) == (0, 1)
          assert sum_product([1, 1, 1]) == (3, 1)
          assert sum_product([100, 0]) == (100, 0)
          assert sum_product([3, 5, 7]) == (3 + 5 + 7, 3 * 5 * 7)
          assert sum_product([10]) == (10, 10)

      """

  Scenario: Agent implements sum_product so all tests pass
    Given an agent is tasked with implementing the sum_product function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
