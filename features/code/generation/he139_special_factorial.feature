Feature: HumanEval/139 — implement special_factorial
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def special_factorial(n):
          '''The Brazilian factorial is defined as:
          brazilian_factorial(n) = n! * (n-1)! * (n-2)! * ... * 1!
          where n > 0

          For example:
          >>> special_factorial(4)
          288

          The function will receive an integer as input and should return the special
          factorial of this integer.
          '''
          pass

      === test_solution.py ===
      from solution import special_factorial


      def test_humaneval():

          # Check some simple cases
          assert special_factorial(4) == 288, "Test 4"
          assert special_factorial(5) == 34560, "Test 5"
          assert special_factorial(7) == 125411328000, "Test 7"

          # Check some edge cases that are easy to work out by hand.
          assert special_factorial(1) == 1, "Test 1"


      """

  Scenario: Agent implements special_factorial so all tests pass
    Given an agent is tasked with implementing the special_factorial function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
