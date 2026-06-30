Feature: MBPP/124 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def angle_complex():
          pass

      === test_solution.py ===
      from solution import angle_complex


      def test_mbpp():
          assert math.isclose(angle_complex(0,1j), 1.5707963267948966, rel_tol=0.001)
          assert math.isclose(angle_complex(2,1j), 0.4636476090008061, rel_tol=0.001)
          assert math.isclose(angle_complex(0,2j), 1.5707963267948966, rel_tol=0.001)

      """

  Scenario: Agent implements angle_complex so all pytest tests pass
    Given an agent is tasked with implementing the angle_complex function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
