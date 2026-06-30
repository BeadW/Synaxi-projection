Feature: MBPP/287 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def square_Sum(n):
          pass

      === test_solution.py ===
      from solution import square_Sum


      def test_mbpp():
          assert square_Sum(2) == 20
          assert square_Sum(3) == 56
          assert square_Sum(4) == 120

      """

  Scenario: Agent implements square_Sum so all pytest tests pass
    Given an agent is tasked with implementing the square_Sum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
