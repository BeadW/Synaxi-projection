Feature: HumanEval/121 — implement solution
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def solution(lst):
          '''Given a non-empty list of integers, return the sum of all of the odd elements that are in even positions.
    

          Examples
          solution([5, 8, 7, 1]) ==> 12
          solution([3, 3, 3, 3, 3]) ==> 9
          solution([30, 13, 24, 321]) ==>0
          '''
          pass

      === test_solution.py ===
      from solution import solution


      def test_humaneval():

          # Check some simple cases
          assert solution([5, 8, 7, 1])    == 12
          assert solution([3, 3, 3, 3, 3]) == 9
          assert solution([30, 13, 24, 321]) == 0
          assert solution([5, 9]) == 5
          assert solution([2, 4, 8]) == 0
          assert solution([30, 13, 23, 32]) == 23
          assert solution([3, 13, 2, 9]) == 3

          # Check some edge cases that are easy to work out by hand.


      """

  Scenario: Agent implements solution so all tests pass
    Given an agent is tasked with implementing the solution function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
