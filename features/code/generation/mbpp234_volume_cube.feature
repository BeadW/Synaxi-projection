Feature: MBPP/234 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def volume_cube(l):
          pass

      === test_solution.py ===
      from solution import volume_cube


      def test_mbpp():
          assert volume_cube(3)==27
          assert volume_cube(2)==8
          assert volume_cube(5)==125

      """

  Scenario: Agent implements volume_cube so all pytest tests pass
    Given an agent is tasked with implementing the volume_cube function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
