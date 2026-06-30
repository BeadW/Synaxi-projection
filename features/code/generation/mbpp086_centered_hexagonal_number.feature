Feature: MBPP/86 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def centered_hexagonal_number(n):
          pass

      === test_solution.py ===
      from solution import centered_hexagonal_number


      def test_mbpp():
          assert centered_hexagonal_number(10) == 271
          assert centered_hexagonal_number(2) == 7
          assert centered_hexagonal_number(9) == 217

      """

  Scenario: Agent implements centered_hexagonal_number so all pytest tests pass
    Given an agent is tasked with implementing the centered_hexagonal_number function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
