Feature: MBPP/430 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def parabola_directrix(a, b, c):
          pass

      === test_solution.py ===
      from solution import parabola_directrix


      def test_mbpp():
          assert parabola_directrix(5,3,2)==-198
          assert parabola_directrix(9,8,4)==-2336
          assert parabola_directrix(2,4,6)==-130

      """

  Scenario: Agent implements parabola_directrix so all pytest tests pass
    Given an agent is tasked with implementing the parabola_directrix function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
