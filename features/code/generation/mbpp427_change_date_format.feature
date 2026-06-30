Feature: MBPP/427 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def change_date_format():
          pass

      === test_solution.py ===
      from solution import change_date_format


      def test_mbpp():
          assert change_date_format("2026-01-02") == '02-01-2026'
          assert change_date_format("2020-11-13") == '13-11-2020'
          assert change_date_format("2021-04-26") == '26-04-2021'

      """

  Scenario: Agent implements change_date_format so all pytest tests pass
    Given an agent is tasked with implementing the change_date_format function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
