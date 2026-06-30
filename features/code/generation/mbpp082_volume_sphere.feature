Feature: MBPP/82 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def volume_sphere():
          pass

      === test_solution.py ===
      from solution import volume_sphere


      def test_mbpp():
          assert math.isclose(volume_sphere(10), 4188.790204786391, rel_tol=0.001)
          assert math.isclose(volume_sphere(25), 65449.84694978735, rel_tol=0.001)
          assert math.isclose(volume_sphere(20), 33510.32163829113, rel_tol=0.001)

      """

  Scenario: Agent implements volume_sphere so all pytest tests pass
    Given an agent is tasked with implementing the volume_sphere function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
