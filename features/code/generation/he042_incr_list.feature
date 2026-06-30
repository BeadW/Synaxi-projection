Feature: HumanEval/42 — implement incr_list
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def incr_list(l: list):
          '''Return list with elements incremented by 1.
          >>> incr_list([1, 2, 3])
          [2, 3, 4]
          >>> incr_list([5, 3, 5, 2, 3, 3, 9, 0, 123])
          [6, 4, 6, 3, 4, 4, 10, 1, 124]
          '''
          pass

      === test_solution.py ===
      from solution import incr_list


      def test_humaneval():
          assert incr_list([]) == []
          assert incr_list([3, 2, 1]) == [4, 3, 2]
          assert incr_list([5, 2, 5, 2, 3, 3, 9, 0, 123]) == [6, 3, 6, 3, 4, 4, 10, 1, 124]


      """

  Scenario: Agent implements incr_list so all tests pass
    Given an agent is tasked with implementing the incr_list function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
