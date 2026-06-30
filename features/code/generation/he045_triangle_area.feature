Feature: HumanEval/45 — implement triangle_area
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def triangle_area(a, h):
          '''Given length of a side and high return area for a triangle.
          >>> triangle_area(5, 3)
          7.5
          '''
          pass

      === test_solution.py ===
      from solution import triangle_area


      def test_humaneval():
          assert triangle_area(5, 3) == 7.5
          assert triangle_area(2, 2) == 2.0
          assert triangle_area(10, 8) == 40.0


      """

  Scenario: Agent implements triangle_area so all tests pass
    Given an agent is tasked with implementing the triangle_area function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
