Feature: HumanEval/28 — implement concatenate
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List


      def concatenate(strings: List[str]) -> str:
          ''' Concatenate list of strings into a single string
          >>> concatenate([])
          ''
          >>> concatenate(['a', 'b', 'c'])
          'abc'
          '''
          pass

      === test_solution.py ===
      from solution import concatenate


      def test_humaneval():
          assert concatenate([]) == ''
          assert concatenate(['x', 'y', 'z']) == 'xyz'
          assert concatenate(['x', 'y', 'z', 'w', 'k']) == 'xyzwk'

      """

  Scenario: Agent implements concatenate so all tests pass
    Given an agent is tasked with implementing the concatenate function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
