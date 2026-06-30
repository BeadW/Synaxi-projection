Feature: MBPP/127 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def multiply_int(x, y):
          pass

      === test_solution.py ===
      from solution import multiply_int


      def test_mbpp():
          assert multiply_int(10,20)==200
          assert multiply_int(5,10)==50
          assert multiply_int(4,8)==32

      """

  Scenario: Agent implements multiply_int so all pytest tests pass
    Given an agent is tasked with implementing the multiply_int function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
