Feature: HumanEval/163 — implement generate_integers
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def generate_integers(a, b):
          '''
          Given two positive integers a and b, return the even digits between a
          and b, in ascending order.

          For example:
          generate_integers(2, 8) => [2, 4, 6, 8]
          generate_integers(8, 2) => [2, 4, 6, 8]
          generate_integers(10, 14) => []
          '''
          pass

      === test_solution.py ===
      from solution import generate_integers


      def test_humaneval():

          # Check some simple cases
          assert generate_integers(2, 10) == [2, 4, 6, 8], "Test 1"
          assert generate_integers(10, 2) == [2, 4, 6, 8], "Test 2"
          assert generate_integers(132, 2) == [2, 4, 6, 8], "Test 3"
          assert generate_integers(17,89) == [], "Test 4"

          # Check some edge cases that are easy to work out by hand.
          assert True, "This prints if this assert fails 2 (also good for debugging!)"


      """

  Scenario: Agent implements generate_integers so all tests pass
    Given an agent is tasked with implementing the generate_integers function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
