Feature: MBPP/85 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def surfacearea_sphere():
          pass

      === test_solution.py ===
      from solution import surfacearea_sphere


      def test_mbpp():
          assert math.isclose(surfacearea_sphere(10), 1256.6370614359173, rel_tol=0.001)
          assert math.isclose(surfacearea_sphere(15), 2827.4333882308138, rel_tol=0.001)
          assert math.isclose(surfacearea_sphere(20), 5026.548245743669, rel_tol=0.001)

      """

  Scenario: Agent implements surfacearea_sphere so all pytest tests pass
    Given an agent is tasked with implementing the surfacearea_sphere function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
