Feature: HumanEval/58 — implement common
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def common(l1: list, l2: list):
          '''Return sorted unique common elements for two lists.
          >>> common([1, 4, 3, 34, 653, 2, 5], [5, 7, 1, 5, 9, 653, 121])
          [1, 5, 653]
          >>> common([5, 3, 2, 8], [3, 2])
          [2, 3]

          '''
          pass

      === test_solution.py ===
      from solution import common


      def test_humaneval():
          assert common([1, 4, 3, 34, 653, 2, 5], [5, 7, 1, 5, 9, 653, 121]) == [1, 5, 653]
          assert common([5, 3, 2, 8], [3, 2]) == [2, 3]
          assert common([4, 3, 2, 8], [3, 2, 4]) == [2, 3, 4]
          assert common([4, 3, 2, 8], []) == []


      """

  Scenario: Agent implements common so all tests pass
    Given an agent is tasked with implementing the common function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
