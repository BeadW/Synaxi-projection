Feature: MBPP/310 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def string_to_tuple(str1):
          pass

      === test_solution.py ===
      from solution import string_to_tuple


      def test_mbpp():
          assert string_to_tuple("python 3.0")==('p', 'y', 't', 'h', 'o', 'n', '3', '.', '0')
          assert string_to_tuple("item1")==('i', 't', 'e', 'm', '1')
          assert string_to_tuple("15.10")==('1', '5', '.', '1', '0')

      """

  Scenario: Agent implements string_to_tuple so all pytest tests pass
    Given an agent is tasked with implementing the string_to_tuple function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
