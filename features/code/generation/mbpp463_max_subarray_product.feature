Feature: MBPP/463 — 
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def max_subarray_product(arr):
          pass

      === test_solution.py ===
      from solution import max_subarray_product


      def test_mbpp():
          assert max_subarray_product([1, -2, -3, 0, 7, -8, -2]) == 112
          assert max_subarray_product([6, -3, -10, 0, 2]) == 180
          assert max_subarray_product([-2, -40, 0, -2, -3]) == 80

      """

  Scenario: Agent implements max_subarray_product so all pytest tests pass
    Given an agent is tasked with implementing the max_subarray_product function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
