Feature: MBPP/420 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def cube_Sum(n):
          pass

      === test_solution.py ===
      from solution import cube_Sum


      def test_mbpp():
          assert cube_Sum(2) == 72
          assert cube_Sum(3) == 288
          assert cube_Sum(4) == 800

      """

  Scenario: Agent implements cube_Sum so all pytest tests pass
    Given an agent is tasked with implementing the cube_Sum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
