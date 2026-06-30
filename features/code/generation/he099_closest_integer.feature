Feature: HumanEval/99 — implement closest_integer
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def closest_integer(value):
          '''
          Create a function that takes a value (string) representing a number
          and returns the closest integer to it. If the number is equidistant
          from two integers, round it away from zero.

          Examples
          >>> closest_integer("10")
          10
          >>> closest_integer("15.3")
          15

          Note:
          Rounding away from zero means that if the given number is equidistant
          from two integers, the one you should return is the one that is the
          farthest from zero. For example closest_integer("14.5") should
          return 15 and closest_integer("-14.5") should return -15.
          '''
          pass

      === test_solution.py ===
      from solution import closest_integer


      def test_humaneval():

          # Check some simple cases
          assert closest_integer("10") == 10, "Test 1"
          assert closest_integer("14.5") == 15, "Test 2"
          assert closest_integer("-15.5") == -16, "Test 3"
          assert closest_integer("15.3") == 15, "Test 3"

          # Check some edge cases that are easy to work out by hand.
          assert closest_integer("0") == 0, "Test 0"


      """

  Scenario: Agent implements closest_integer so all tests pass
    Given an agent is tasked with implementing the closest_integer function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
