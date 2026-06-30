Feature: MBPP/439 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def multiple_to_single(L):
          pass

      === test_solution.py ===
      from solution import multiple_to_single


      def test_mbpp():
          assert multiple_to_single([11, 33, 50])==113350
          assert multiple_to_single([-1,2,3,4,5,6])==-123456
          assert multiple_to_single([10,15,20,25])==10152025

      """

  Scenario: Agent implements multiple_to_single so all pytest tests pass
    Given an agent is tasked with implementing the multiple_to_single function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
