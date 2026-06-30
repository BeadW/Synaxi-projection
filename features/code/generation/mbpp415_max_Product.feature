Feature: MBPP/415 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def max_Product(arr):
          pass

      === test_solution.py ===
      from solution import max_Product


      def test_mbpp():
          assert max_Product([1,2,3,4,7,0,8,4]) == (7,8)
          assert max_Product([0,-1,-2,-4,5,0,-6]) == (-4,-6)
          assert max_Product([1,2,3]) == (2,3)

      """

  Scenario: Agent implements max_Product so all pytest tests pass
    Given an agent is tasked with implementing the max_Product function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
