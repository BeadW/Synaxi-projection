Feature: MBPP/404 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def minimum(a,b):
          pass

      === test_solution.py ===
      from solution import minimum


      def test_mbpp():
          assert minimum(1,2) == 1
          assert minimum(-5,-4) == -5
          assert minimum(0,0) == 0

      """

  Scenario: Agent implements minimum so all pytest tests pass
    Given an agent is tasked with implementing the minimum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
