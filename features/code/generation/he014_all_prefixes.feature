Feature: HumanEval/14 — implement all_prefixes
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List


      def all_prefixes(string: str) -> List[str]:
          ''' Return list of all prefixes from shortest to longest of the input string
          >>> all_prefixes('abc')
          ['a', 'ab', 'abc']
          '''
          pass

      === test_solution.py ===
      from solution import all_prefixes


      def test_humaneval():
          assert all_prefixes('') == []
          assert all_prefixes('asdfgh') == ['a', 'as', 'asd', 'asdf', 'asdfg', 'asdfgh']
          assert all_prefixes('WWW') == ['W', 'WW', 'WWW']

      """

  Scenario: Agent implements all_prefixes so all tests pass
    Given an agent is tasked with implementing the all_prefixes function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
