Feature: MBPP/245 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def max_sum(arr):
          pass

      === test_solution.py ===
      from solution import max_sum


      def test_mbpp():
          assert max_sum([1, 15, 51, 45, 33, 100, 12, 18, 9]) == 194
          assert max_sum([80, 60, 30, 40, 20, 10]) == 210
          assert max_sum([2, 3 ,14, 16, 21, 23, 29, 30]) == 138

      """

  Scenario: Agent implements max_sum so all pytest tests pass
    Given an agent is tasked with implementing the max_sum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
