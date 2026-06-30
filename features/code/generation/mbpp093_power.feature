Feature: MBPP/93 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def power(a,b):
          pass

      === test_solution.py ===
      from solution import power


      def test_mbpp():
          assert power(3,4) == 81
          assert power(2,3) == 8
          assert power(5,5) == 3125

      """

  Scenario: Agent implements power so all pytest tests pass
    Given an agent is tasked with implementing the power function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
