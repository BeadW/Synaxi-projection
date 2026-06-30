Feature: MBPP/448 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def cal_sum(n):
          pass

      === test_solution.py ===
      from solution import cal_sum


      def test_mbpp():
          assert cal_sum(9) == 49
          assert cal_sum(10) == 66
          assert cal_sum(11) == 88

      """

  Scenario: Agent implements cal_sum so all pytest tests pass
    Given an agent is tasked with implementing the cal_sum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
