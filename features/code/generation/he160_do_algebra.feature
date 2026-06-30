Feature: HumanEval/160 — implement do_algebra
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def do_algebra(operator, operand):
          '''
          Given two lists operator, and operand. The first list has basic algebra operations, and 
          the second list is a list of integers. Use the two given lists to build the algebric 
          expression and return the evaluation of this expression.

          The basic algebra operations:
          Addition ( + ) 
          Subtraction ( - ) 
          Multiplication ( * ) 
          Floor division ( // ) 
          Exponentiation ( ** ) 

          Example:
          operator['+', '*', '-']
          array = [2, 3, 4, 5]
          result = 2 + 3 * 4 - 5
          => result = 9

          Note:
              The length of operator list is equal to the length of operand list minus one.
              Operand is a list of of non-negative integers.
              Operator list has at least one operator, and operand list has at least two operands.

          '''
          pass

      === test_solution.py ===
      from solution import do_algebra


      def test_humaneval():

          # Check some simple cases
          assert do_algebra(['**', '*', '+'], [2, 3, 4, 5]) == 37
          assert do_algebra(['+', '*', '-'], [2, 3, 4, 5]) == 9
          assert do_algebra(['//', '*'], [7, 3, 4]) == 8, "This prints if this assert fails 1 (good for debugging!)"

          # Check some edge cases that are easy to work out by hand.
          assert True, "This prints if this assert fails 2 (also good for debugging!)"


      """

  Scenario: Agent implements do_algebra so all tests pass
    Given an agent is tasked with implementing the do_algebra function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
