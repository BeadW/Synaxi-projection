Feature: MBPP/468 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def max_product(arr):
          pass

      === test_solution.py ===
      from solution import max_product


      def test_mbpp():
          assert max_product([3, 100, 4, 5, 150, 6]) == 3000
          assert max_product([4, 42, 55, 68, 80]) == 50265600
          assert max_product([10, 22, 9, 33, 21, 50, 41, 60]) == 2460

      """

  Scenario: Agent implements max_product so all pytest tests pass
    Given an agent is tasked with implementing the max_product function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
