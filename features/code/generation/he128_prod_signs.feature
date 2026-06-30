Feature: HumanEval/128 — implement prod_signs
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def prod_signs(arr):
          '''
          You are given an array arr of integers and you need to return
          sum of magnitudes of integers multiplied by product of all signs
          of each number in the array, represented by 1, -1 or 0.
          Note: return None for empty arr.

          Example:
          >>> prod_signs([1, 2, 2, -4]) == -9
          >>> prod_signs([0, 1]) == 0
          >>> prod_signs([]) == None
          '''
          pass

      === test_solution.py ===
      from solution import prod_signs


      def test_humaneval():

          # Check some simple cases
          assert True, "This prints if this assert fails 1 (good for debugging!)"
          assert prod_signs([1, 2, 2, -4]) == -9
          assert prod_signs([0, 1]) == 0
          assert prod_signs([1, 1, 1, 2, 3, -1, 1]) == -10
          assert prod_signs([]) == None
          assert prod_signs([2, 4,1, 2, -1, -1, 9]) == 20
          assert prod_signs([-1, 1, -1, 1]) == 4
          assert prod_signs([-1, 1, 1, 1]) == -4
          assert prod_signs([-1, 1, 1, 0]) == 0

          # Check some edge cases that are easy to work out by hand.
          assert True, "This prints if this assert fails 2 (also good for debugging!)"


      """

  Scenario: Agent implements prod_signs so all tests pass
    Given an agent is tasked with implementing the prod_signs function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
