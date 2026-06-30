Feature: MBPP/458 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def rectangle_area(l,b):
          pass

      === test_solution.py ===
      from solution import rectangle_area


      def test_mbpp():
          assert rectangle_area(10,20)==200
          assert rectangle_area(10,5)==50
          assert rectangle_area(4,2)==8

      """

  Scenario: Agent implements rectangle_area so all pytest tests pass
    Given an agent is tasked with implementing the rectangle_area function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
