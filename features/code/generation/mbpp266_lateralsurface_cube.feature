Feature: MBPP/266 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def lateralsurface_cube(l):
          pass

      === test_solution.py ===
      from solution import lateralsurface_cube


      def test_mbpp():
          assert lateralsurface_cube(5)==100
          assert lateralsurface_cube(9)==324
          assert lateralsurface_cube(10)==400

      """

  Scenario: Agent implements lateralsurface_cube so all pytest tests pass
    Given an agent is tasked with implementing the lateralsurface_cube function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
