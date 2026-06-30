Feature: HumanEval/37 — implement sort_even
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def sort_even(l: list):
          '''This function takes a list l and returns a list l' such that
          l' is identical to l in the odd indicies, while its values at the even indicies are equal
          to the values of the even indicies of l, but sorted.
          >>> sort_even([1, 2, 3])
          [1, 2, 3]
          >>> sort_even([5, 6, 3, 4])
          [3, 6, 5, 4]
          '''
          pass

      === test_solution.py ===
      from solution import sort_even


      def test_humaneval():
          assert tuple(sort_even([1, 2, 3])) == tuple([1, 2, 3])
          assert tuple(sort_even([5, 3, -5, 2, -3, 3, 9, 0, 123, 1, -10])) == tuple([-10, 3, -5, 2, -3, 3, 5, 0, 9, 1, 123])
          assert tuple(sort_even([5, 8, -12, 4, 23, 2, 3, 11, 12, -10])) == tuple([-12, 8, 3, 4, 5, 2, 12, 11, 23, -10])


      """

  Scenario: Agent implements sort_even so all tests pass
    Given an agent is tasked with implementing the sort_even function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
