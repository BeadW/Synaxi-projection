Feature: MBPP/109 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def odd_Equivalent(s,n):
          pass

      === test_solution.py ===
      from solution import odd_Equivalent


      def test_mbpp():
          assert odd_Equivalent("011001",6) == 3
          assert odd_Equivalent("11011",5) == 4
          assert odd_Equivalent("1010",4) == 2

      """

  Scenario: Agent implements odd_Equivalent so all pytest tests pass
    Given an agent is tasked with implementing the odd_Equivalent function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
