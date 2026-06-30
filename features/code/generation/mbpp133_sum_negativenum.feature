Feature: MBPP/133 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def sum_negativenum(nums):
          pass

      === test_solution.py ===
      from solution import sum_negativenum


      def test_mbpp():
          assert sum_negativenum([2, 4, -6, -9, 11, -12, 14, -5, 17])==-32
          assert sum_negativenum([10,15,-14,13,-18,12,-20])==-52
          assert sum_negativenum([19, -65, 57, 39, 152,-639, 121, 44, 90, -190])==-894

      """

  Scenario: Agent implements sum_negativenum so all pytest tests pass
    Given an agent is tasked with implementing the sum_negativenum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
