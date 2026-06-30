Feature: MBPP/118 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def string_to_list(string):
          pass

      === test_solution.py ===
      from solution import string_to_list


      def test_mbpp():
          assert string_to_list("python programming")==['python','programming']
          assert string_to_list("lists tuples strings")==['lists','tuples','strings']
          assert string_to_list("write a program")==['write','a','program']

      """

  Scenario: Agent implements string_to_list so all pytest tests pass
    Given an agent is tasked with implementing the string_to_list function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
