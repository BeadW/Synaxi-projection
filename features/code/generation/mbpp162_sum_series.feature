Feature: MBPP/162 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def sum_series(n):
          pass

      === test_solution.py ===
      from solution import sum_series


      def test_mbpp():
          assert sum_series(6) == 12
          assert sum_series(10) == 30
          assert sum_series(9) == 25

      """

  Scenario: Agent implements sum_series so all pytest tests pass
    Given an agent is tasked with implementing the sum_series function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
