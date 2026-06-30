Feature: MBPP/228 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def all_Bits_Set_In_The_Given_Range(n,l,r):
          pass

      === test_solution.py ===
      from solution import all_Bits_Set_In_The_Given_Range


      def test_mbpp():
          assert all_Bits_Set_In_The_Given_Range(4,1,2) == True
          assert all_Bits_Set_In_The_Given_Range(17,2,4) == True
          assert all_Bits_Set_In_The_Given_Range(39,4,6) == False

      """

  Scenario: Agent implements all_Bits_Set_In_The_Given_Range so all pytest tests pass
    Given an agent is tasked with implementing the all_Bits_Set_In_The_Given_Range function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
