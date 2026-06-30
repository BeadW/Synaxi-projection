Feature: MBPP/224 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def count_Set_Bits(n):
          pass

      === test_solution.py ===
      from solution import count_Set_Bits


      def test_mbpp():
          assert count_Set_Bits(2) == 1
          assert count_Set_Bits(4) == 1
          assert count_Set_Bits(6) == 2

      """

  Scenario: Agent implements count_Set_Bits so all pytest tests pass
    Given an agent is tasked with implementing the count_Set_Bits function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
