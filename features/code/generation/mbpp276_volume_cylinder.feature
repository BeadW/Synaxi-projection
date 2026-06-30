Feature: MBPP/276 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def volume_cylinder(r,h):
          pass

      === test_solution.py ===
      from solution import volume_cylinder


      def test_mbpp():
          assert math.isclose(volume_cylinder(10,5), 1570.7500000000002, rel_tol=0.001)
          assert math.isclose(volume_cylinder(4,5), 251.32000000000002, rel_tol=0.001)
          assert math.isclose(volume_cylinder(4,10), 502.64000000000004, rel_tol=0.001)

      """

  Scenario: Agent implements volume_cylinder so all pytest tests pass
    Given an agent is tasked with implementing the volume_cylinder function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
