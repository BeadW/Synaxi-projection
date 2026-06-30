Feature: MBPP/271 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def even_Power_Sum(n):
          pass

      === test_solution.py ===
      from solution import even_Power_Sum


      def test_mbpp():
          assert even_Power_Sum(2) == 1056
          assert even_Power_Sum(3) == 8832
          assert even_Power_Sum(1) == 32

      """

  Scenario: Agent implements even_Power_Sum so all pytest tests pass
    Given an agent is tasked with implementing the even_Power_Sum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
