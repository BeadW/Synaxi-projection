Feature: HumanEval/132 — implement is_nested
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def is_nested(string):
          '''
          Create a function that takes a string as input which contains only square brackets.
          The function should return True if and only if there is a valid subsequence of brackets 
          where at least one bracket in the subsequence is nested.

          is_nested('[[]]') ➞ True
          is_nested('[]]]]]]][[[[[]') ➞ False
          is_nested('[][]') ➞ False
          is_nested('[]') ➞ False
          is_nested('[[][]]') ➞ True
          is_nested('[[]][[') ➞ True
          '''
          pass

      === test_solution.py ===
      from solution import is_nested


      def test_humaneval():

          # Check some simple cases
          assert is_nested('[[]]') == True, "This prints if this assert fails 1 (good for debugging!)"
          assert is_nested('[]]]]]]][[[[[]') == False
          assert is_nested('[][]') == False
          assert is_nested(('[]')) == False
          assert is_nested('[[[[]]]]') == True
          assert is_nested('[]]]]]]]]]]') == False
          assert is_nested('[][][[]]') == True
          assert is_nested('[[]') == False
          assert is_nested('[]]') == False
          assert is_nested('[[]][[') == True
          assert is_nested('[[][]]') == True

          # Check some edge cases that are easy to work out by hand.
          assert is_nested('') == False, "This prints if this assert fails 2 (also good for debugging!)"
          assert is_nested('[[[[[[[[') == False
          assert is_nested(']]]]]]]]') == False


      """

  Scenario: Agent implements is_nested so all tests pass
    Given an agent is tasked with implementing the is_nested function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
