Feature: MBPP/435 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def last_Digit(n) :
          pass

      === test_solution.py ===
      from solution import last_Digit


      def test_mbpp():
          assert last_Digit(123) == 3
          assert last_Digit(25) == 5
          assert last_Digit(30) == 0

      """

  Scenario: Agent implements last_Digit so all pytest tests pass
    Given an agent is tasked with implementing the last_Digit function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
