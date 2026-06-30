Feature: MBPP/238 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def number_of_substrings(str):
          pass

      === test_solution.py ===
      from solution import number_of_substrings


      def test_mbpp():
          assert number_of_substrings("abc") == 6
          assert number_of_substrings("abcd") == 10
          assert number_of_substrings("abcde") == 15

      """

  Scenario: Agent implements number_of_substrings so all pytest tests pass
    Given an agent is tasked with implementing the number_of_substrings function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
