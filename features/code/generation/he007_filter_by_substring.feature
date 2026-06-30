Feature: HumanEval/7 — implement filter_by_substring
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List


      def filter_by_substring(strings: List[str], substring: str) -> List[str]:
          ''' Filter an input list of strings only for ones that contain given substring
          >>> filter_by_substring([], 'a')
          []
          >>> filter_by_substring(['abc', 'bacd', 'cde', 'array'], 'a')
          ['abc', 'bacd', 'array']
          '''
          pass

      === test_solution.py ===
      from solution import filter_by_substring


      def test_humaneval():
          assert filter_by_substring([], 'john') == []
          assert filter_by_substring(['xxx', 'asd', 'xxy', 'john doe', 'xxxAAA', 'xxx'], 'xxx') == ['xxx', 'xxxAAA', 'xxx']
          assert filter_by_substring(['xxx', 'asd', 'aaaxxy', 'john doe', 'xxxAAA', 'xxx'], 'xx') == ['xxx', 'aaaxxy', 'xxxAAA', 'xxx']
          assert filter_by_substring(['grunt', 'trumpet', 'prune', 'gruesome'], 'run') == ['grunt', 'prune']

      """

  Scenario: Agent implements filter_by_substring so all tests pass
    Given an agent is tasked with implementing the filter_by_substring function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
