Feature: MBPP/269 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def ascii_value(k):
          pass

      === test_solution.py ===
      from solution import ascii_value


      def test_mbpp():
          assert ascii_value('A')==65
          assert ascii_value('R')==82
          assert ascii_value('S')==83

      """

  Scenario: Agent implements ascii_value so all pytest tests pass
    Given an agent is tasked with implementing the ascii_value function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
