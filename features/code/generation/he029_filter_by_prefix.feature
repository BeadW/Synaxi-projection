Feature: HumanEval/29 — implement filter_by_prefix
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List


      def filter_by_prefix(strings: List[str], prefix: str) -> List[str]:
          ''' Filter an input list of strings only for ones that start with a given prefix.
          >>> filter_by_prefix([], 'a')
          []
          >>> filter_by_prefix(['abc', 'bcd', 'cde', 'array'], 'a')
          ['abc', 'array']
          '''
          pass

      === test_solution.py ===
      from solution import filter_by_prefix


      def test_humaneval():
          assert filter_by_prefix([], 'john') == []
          assert filter_by_prefix(['xxx', 'asd', 'xxy', 'john doe', 'xxxAAA', 'xxx'], 'xxx') == ['xxx', 'xxxAAA', 'xxx']

      """

  Scenario: Agent implements filter_by_prefix so all tests pass
    Given an agent is tasked with implementing the filter_by_prefix function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
