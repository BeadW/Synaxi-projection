Feature: HumanEval/15 — implement string_sequence
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def string_sequence(n: int) -> str:
          ''' Return a string containing space-delimited numbers starting from 0 upto n inclusive.
          >>> string_sequence(0)
          '0'
          >>> string_sequence(5)
          '0 1 2 3 4 5'
          '''
          pass

      === test_solution.py ===
      from solution import string_sequence


      def test_humaneval():
          assert string_sequence(0) == '0'
          assert string_sequence(3) == '0 1 2 3'
          assert string_sequence(10) == '0 1 2 3 4 5 6 7 8 9 10'

      """

  Scenario: Agent implements string_sequence so all tests pass
    Given an agent is tasked with implementing the string_sequence function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
