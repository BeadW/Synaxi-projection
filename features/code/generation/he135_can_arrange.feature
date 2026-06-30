Feature: HumanEval/135 — implement can_arrange
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def can_arrange(arr):
          '''Create a function which returns the largest index of an element which
          is not greater than or equal to the element immediately preceding it. If
          no such element exists then return -1. The given array will not contain
          duplicate values.

          Examples:
          can_arrange([1,2,4,3,5]) = 3
          can_arrange([1,2,3]) = -1
          '''
          pass

      === test_solution.py ===
      from solution import can_arrange


      def test_humaneval():

          # Check some simple cases
          assert can_arrange([1,2,4,3,5])==3
          assert can_arrange([1,2,4,5])==-1
          assert can_arrange([1,4,2,5,6,7,8,9,10])==2
          assert can_arrange([4,8,5,7,3])==4

          # Check some edge cases that are easy to work out by hand.
          assert can_arrange([])==-1


      """

  Scenario: Agent implements can_arrange so all tests pass
    Given an agent is tasked with implementing the can_arrange function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
