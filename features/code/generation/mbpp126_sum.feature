Feature: MBPP/126 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def sum(a,b):
          pass

      === test_solution.py ===
      from solution import sum


      def test_mbpp():
          assert sum(10,15) == 6
          assert sum(100,150) == 93
          assert sum(4,6) == 3

      """

  Scenario: Agent implements sum so all pytest tests pass
    Given an agent is tasked with implementing the sum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
