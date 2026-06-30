Feature: HumanEval/90 — implement next_smallest
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def next_smallest(lst):
          '''
          You are given a list of integers.
          Write a function next_smallest() that returns the 2nd smallest element of the list.
          Return None if there is no such element.
    
          next_smallest([1, 2, 3, 4, 5]) == 2
          next_smallest([5, 1, 4, 3, 2]) == 2
          next_smallest([]) == None
          next_smallest([1, 1]) == None
          '''
          pass

      === test_solution.py ===
      from solution import next_smallest


      def test_humaneval():

          # Check some simple cases
          assert next_smallest([1, 2, 3, 4, 5]) == 2
          assert next_smallest([5, 1, 4, 3, 2]) == 2
          assert next_smallest([]) == None
          assert next_smallest([1, 1]) == None
          assert next_smallest([1,1,1,1,0]) == 1
          assert next_smallest([1, 0**0]) == None
          assert next_smallest([-35, 34, 12, -45]) == -35

          # Check some edge cases that are easy to work out by hand.
          assert True


      """

  Scenario: Agent implements next_smallest so all tests pass
    Given an agent is tasked with implementing the next_smallest function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
