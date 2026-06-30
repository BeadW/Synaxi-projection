Feature: MBPP/61 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def count_Substrings():
          pass

      === test_solution.py ===
      from solution import count_Substrings


      def test_mbpp():
          assert count_Substrings('112112') == 6
          assert count_Substrings('111') == 6
          assert count_Substrings('1101112') == 12

      """

  Scenario: Agent implements count_Substrings so all pytest tests pass
    Given an agent is tasked with implementing the count_Substrings function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
