Feature: MBPP/479 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def first_Digit(n) :
          pass

      === test_solution.py ===
      from solution import first_Digit


      def test_mbpp():
          assert first_Digit(123) == 1
          assert first_Digit(456) == 4
          assert first_Digit(12) == 1

      """

  Scenario: Agent implements first_Digit so all pytest tests pass
    Given an agent is tasked with implementing the first_Digit function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
