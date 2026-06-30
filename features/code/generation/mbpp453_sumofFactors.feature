Feature: MBPP/453 — 
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def sumofFactors():
          pass

      === test_solution.py ===
      from solution import sumofFactors


      def test_mbpp():
          assert sumofFactors(18) == 26
          assert sumofFactors(30) == 48
          assert sumofFactors(6) == 8

      """

  Scenario: Agent implements sumofFactors so all pytest tests pass
    Given an agent is tasked with implementing the sumofFactors function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
