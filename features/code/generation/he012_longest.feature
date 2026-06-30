Feature: HumanEval/12 — implement longest
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List, Optional


      def longest(strings: List[str]) -> Optional[str]:
          ''' Out of list of strings, return the longest one. Return the first one in case of multiple
          strings of the same length. Return None in case the input list is empty.
          >>> longest([])

          >>> longest(['a', 'b', 'c'])
          'a'
          >>> longest(['a', 'bb', 'ccc'])
          'ccc'
          '''
          pass

      === test_solution.py ===
      from solution import longest


      def test_humaneval():
          assert longest([]) == None
          assert longest(['x', 'y', 'z']) == 'x'
          assert longest(['x', 'yyy', 'zzzz', 'www', 'kkkk', 'abc']) == 'zzzz'

      """

  Scenario: Agent implements longest so all tests pass
    Given an agent is tasked with implementing the longest function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
