Feature: MBPP/163 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def area_polygon():
          pass

      === test_solution.py ===
      from solution import area_polygon


      def test_mbpp():
          assert math.isclose(area_polygon(4, 20), 400., rel_tol=0.001)
          assert math.isclose(area_polygon(10, 15), 1731.197, rel_tol=0.001)
          assert math.isclose(area_polygon(9, 7), 302.909, rel_tol=0.001)

      """

  Scenario: Agent implements area_polygon so all pytest tests pass
    Given an agent is tasked with implementing the area_polygon function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
