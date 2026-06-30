Feature: MBPP/116 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def tuple_to_int(nums):
          pass

      === test_solution.py ===
      from solution import tuple_to_int


      def test_mbpp():
          assert tuple_to_int((1,2,3))==123
          assert tuple_to_int((4,5,6))==456
          assert tuple_to_int((5,6,7))==567

      """

  Scenario: Agent implements tuple_to_int so all pytest tests pass
    Given an agent is tasked with implementing the tuple_to_int function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
