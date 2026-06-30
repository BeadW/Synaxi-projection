Feature: MBPP/84 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def sequence(n):
          pass

      === test_solution.py ===
      from solution import sequence


      def test_mbpp():
          assert sequence(10) == 6
          assert sequence(2) == 1
          assert sequence(3) == 2

      """

  Scenario: Agent implements sequence so all pytest tests pass
    Given an agent is tasked with implementing the sequence function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
