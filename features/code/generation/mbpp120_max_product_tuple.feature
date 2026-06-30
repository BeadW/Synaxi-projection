Feature: MBPP/120 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def max_product_tuple(list1):
          pass

      === test_solution.py ===
      from solution import max_product_tuple


      def test_mbpp():
          assert max_product_tuple([(2, 7), (2, 6), (1, 8), (4, 9)] )==36
          assert max_product_tuple([(10,20), (15,2), (5,10)] )==200
          assert max_product_tuple([(11,44), (10,15), (20,5), (12, 9)] )==484

      """

  Scenario: Agent implements max_product_tuple so all pytest tests pass
    Given an agent is tasked with implementing the max_product_tuple function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
