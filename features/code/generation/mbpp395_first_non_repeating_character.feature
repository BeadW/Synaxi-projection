Feature: MBPP/395 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def first_non_repeating_character(str1):
          pass

      === test_solution.py ===
      from solution import first_non_repeating_character


      def test_mbpp():
          assert first_non_repeating_character("abcabc") == None
          assert first_non_repeating_character("abc") == "a"
          assert first_non_repeating_character("ababc") == "c"

      """

  Scenario: Agent implements first_non_repeating_character so all pytest tests pass
    Given an agent is tasked with implementing the first_non_repeating_character function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
