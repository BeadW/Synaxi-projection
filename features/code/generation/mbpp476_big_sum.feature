Feature: MBPP/476 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def big_sum(nums):
          pass

      === test_solution.py ===
      from solution import big_sum


      def test_mbpp():
          assert big_sum([1,2,3]) == 4
          assert big_sum([-1,2,3,4]) == 3
          assert big_sum([2,3,6]) == 8

      """

  Scenario: Agent implements big_sum so all pytest tests pass
    Given an agent is tasked with implementing the big_sum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
