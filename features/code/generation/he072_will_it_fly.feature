Feature: HumanEval/72 — implement will_it_fly
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def will_it_fly(q,w):
          '''
          Write a function that returns True if the object q will fly, and False otherwise.
          The object q will fly if it's balanced (it is a palindromic list) and the sum of its elements is less than or equal the maximum possible weight w.

          Example:
          will_it_fly([1, 2], 5) ➞ False 
          # 1+2 is less than the maximum possible weight, but it's unbalanced.

          will_it_fly([3, 2, 3], 1) ➞ False
          # it's balanced, but 3+2+3 is more than the maximum possible weight.

          will_it_fly([3, 2, 3], 9) ➞ True
          # 3+2+3 is less than the maximum possible weight, and it's balanced.

          will_it_fly([3], 5) ➞ True
          # 3 is less than the maximum possible weight, and it's balanced.
          '''
          pass

      === test_solution.py ===
      from solution import will_it_fly


      def test_humaneval():

          # Check some simple cases
          assert will_it_fly([3, 2, 3], 9) is True
          assert will_it_fly([1, 2], 5) is False
          assert will_it_fly([3], 5) is True
          assert will_it_fly([3, 2, 3], 1) is False


          # Check some edge cases that are easy to work out by hand.
          assert will_it_fly([1, 2, 3], 6) is False
          assert will_it_fly([5], 5) is True


      """

  Scenario: Agent implements will_it_fly so all tests pass
    Given an agent is tasked with implementing the will_it_fly function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
