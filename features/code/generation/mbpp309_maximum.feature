Feature: MBPP/309 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def maximum(a,b):
          pass

      === test_solution.py ===
      from solution import maximum


      def test_mbpp():
          assert maximum(5,10) == 10
          assert maximum(-1,-2) == -1
          assert maximum(9,7) == 9

      """

  Scenario: Agent implements maximum so all pytest tests pass
    Given an agent is tasked with implementing the maximum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
