Feature: MBPP/145 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def max_Abs_Diff(arr):
          pass

      === test_solution.py ===
      from solution import max_Abs_Diff


      def test_mbpp():
          assert max_Abs_Diff((2,1,5,3)) == 4
          assert max_Abs_Diff((9,3,2,5,1)) == 8
          assert max_Abs_Diff((3,2,1)) == 2

      """

  Scenario: Agent implements max_Abs_Diff so all pytest tests pass
    Given an agent is tasked with implementing the max_Abs_Diff function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
