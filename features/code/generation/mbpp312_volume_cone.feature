Feature: MBPP/312 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def volume_cone():
          pass

      === test_solution.py ===
      from solution import volume_cone


      def test_mbpp():
          assert math.isclose(volume_cone(5,12), 314.15926535897927, rel_tol=0.001)
          assert math.isclose(volume_cone(10,15), 1570.7963267948965, rel_tol=0.001)
          assert math.isclose(volume_cone(19,17), 6426.651371693521, rel_tol=0.001)

      """

  Scenario: Agent implements volume_cone so all pytest tests pass
    Given an agent is tasked with implementing the volume_cone function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
