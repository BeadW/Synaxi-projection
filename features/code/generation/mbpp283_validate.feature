Feature: MBPP/283 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def validate(n):
          pass

      === test_solution.py ===
      from solution import validate


      def test_mbpp():
          assert validate(1234) == True
          assert validate(51241) == False
          assert validate(321) == True

      """

  Scenario: Agent implements validate so all pytest tests pass
    Given an agent is tasked with implementing the validate function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
