Feature: MBPP/96 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def divisor(n):
          pass

      === test_solution.py ===
      from solution import divisor


      def test_mbpp():
          assert divisor(15) == 4
          assert divisor(12) == 6
          assert divisor(9) == 3

      """

  Scenario: Agent implements divisor so all pytest tests pass
    Given an agent is tasked with implementing the divisor function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
