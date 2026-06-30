Feature: MBPP/441 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def surfacearea_cube(l):
          pass

      === test_solution.py ===
      from solution import surfacearea_cube


      def test_mbpp():
          assert surfacearea_cube(5)==150
          assert surfacearea_cube(3)==54
          assert surfacearea_cube(10)==600

      """

  Scenario: Agent implements surfacearea_cube so all pytest tests pass
    Given an agent is tasked with implementing the surfacearea_cube function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
