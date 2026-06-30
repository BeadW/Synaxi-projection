Feature: HumanEval/108 — implement count_nums
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def count_nums(arr):
          '''
          Write a function count_nums which takes an array of integers and returns
          the number of elements which has a sum of digits > 0.
          If a number is negative, then its first signed digit will be negative:
          e.g. -123 has signed digits -1, 2, and 3.
          >>> count_nums([]) == 0
          >>> count_nums([-1, 11, -11]) == 1
          >>> count_nums([1, 1, 2]) == 3
          '''
          pass

      === test_solution.py ===
      from solution import count_nums


      def test_humaneval():

          # Check some simple cases
          assert count_nums([]) == 0
          assert count_nums([-1, -2, 0]) == 0
          assert count_nums([1, 1, 2, -2, 3, 4, 5]) == 6
          assert count_nums([1, 6, 9, -6, 0, 1, 5]) == 5
          assert count_nums([1, 100, 98, -7, 1, -1]) == 4
          assert count_nums([12, 23, 34, -45, -56, 0]) == 5
          assert count_nums([-0, 1**0]) == 1
          assert count_nums([1]) == 1

          # Check some edge cases that are easy to work out by hand.
          assert True, "This prints if this assert fails 2 (also good for debugging!)"


      """

  Scenario: Agent implements count_nums so all tests pass
    Given an agent is tasked with implementing the count_nums function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
