Feature: MBPP/20 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def is_woodall(x):
          pass

      === test_solution.py ===
      from solution import is_woodall


      def test_mbpp():
          assert is_woodall(383) == True
          assert is_woodall(254) == False
          assert is_woodall(200) == False

      """

  Scenario: Agent implements is_woodall so all pytest tests pass
    Given an agent is tasked with implementing the is_woodall function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
