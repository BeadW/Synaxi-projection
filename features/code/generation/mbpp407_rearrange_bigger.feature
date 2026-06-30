Feature: MBPP/407 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def rearrange_bigger(n):
          pass

      === test_solution.py ===
      from solution import rearrange_bigger


      def test_mbpp():
          assert rearrange_bigger(12)==21
          assert rearrange_bigger(10)==False
          assert rearrange_bigger(102)==120

      """

  Scenario: Agent implements rearrange_bigger so all pytest tests pass
    Given an agent is tasked with implementing the rearrange_bigger function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
