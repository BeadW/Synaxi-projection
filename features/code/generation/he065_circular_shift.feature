Feature: HumanEval/65 — implement circular_shift
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def circular_shift(x, shift):
          '''Circular shift the digits of the integer x, shift the digits right by shift
          and return the result as a string.
          If shift > number of digits, return digits reversed.
          >>> circular_shift(12, 1)
          "21"
          >>> circular_shift(12, 2)
          "12"
          '''
          pass

      === test_solution.py ===
      from solution import circular_shift


      def test_humaneval():

          # Check some simple cases
          assert circular_shift(100, 2) == "001"
          assert circular_shift(12, 2) == "12"
          assert circular_shift(97, 8) == "79"
          assert circular_shift(12, 1) == "21", "This prints if this assert fails 1 (good for debugging!)"

          # Check some edge cases that are easy to work out by hand.
          assert circular_shift(11, 101) == "11", "This prints if this assert fails 2 (also good for debugging!)"


      """

  Scenario: Agent implements circular_shift so all tests pass
    Given an agent is tasked with implementing the circular_shift function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
