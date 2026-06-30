Feature: MBPP/233 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def lateralsuface_cylinder(r,h):
          pass

      === test_solution.py ===
      from solution import lateralsuface_cylinder


      def test_mbpp():
          assert math.isclose(lateralsuface_cylinder(10,5), 314.15000000000003, rel_tol=0.001)
          assert math.isclose(lateralsuface_cylinder(4,5), 125.66000000000001, rel_tol=0.001)
          assert math.isclose(lateralsuface_cylinder(4,10), 251.32000000000002, rel_tol=0.001)

      """

  Scenario: Agent implements lateralsuface_cylinder so all pytest tests pass
    Given an agent is tasked with implementing the lateralsuface_cylinder function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
