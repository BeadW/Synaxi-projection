Feature: MBPP/244 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def next_Perfect_Square():
          pass

      === test_solution.py ===
      from solution import next_Perfect_Square


      def test_mbpp():
          assert next_Perfect_Square(35) == 36
          assert next_Perfect_Square(6) == 9
          assert next_Perfect_Square(9) == 16

      """

  Scenario: Agent implements next_Perfect_Square so all pytest tests pass
    Given an agent is tasked with implementing the next_Perfect_Square function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
