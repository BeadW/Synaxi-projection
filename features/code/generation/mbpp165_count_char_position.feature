Feature: MBPP/165 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def count_char_position(str1):
          pass

      === test_solution.py ===
      from solution import count_char_position


      def test_mbpp():
          assert count_char_position("xbcefg") == 2
          assert count_char_position("ABcED") == 3
          assert count_char_position("AbgdeF") == 5

      """

  Scenario: Agent implements count_char_position so all pytest tests pass
    Given an agent is tasked with implementing the count_char_position function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
