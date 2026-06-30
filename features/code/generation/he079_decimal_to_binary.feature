Feature: HumanEval/79 — implement decimal_to_binary
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def decimal_to_binary(decimal):
          '''You will be given a number in decimal form and your task is to convert it to
          binary format. The function should return a string, with each character representing a binary
          number. Each character in the string will be '0' or '1'.

          There will be an extra couple of characters 'db' at the beginning and at the end of the string.
          The extra characters are there to help with the format.

          Examples:
          decimal_to_binary(15)   # returns "db1111db"
          decimal_to_binary(32)   # returns "db100000db"
          '''
          pass

      === test_solution.py ===
      from solution import decimal_to_binary


      def test_humaneval():

          # Check some simple cases
          assert decimal_to_binary(0) == "db0db"
          assert decimal_to_binary(32) == "db100000db"
          assert decimal_to_binary(103) == "db1100111db"
          assert decimal_to_binary(15) == "db1111db", "This prints if this assert fails 1 (good for debugging!)"

          # Check some edge cases that are easy to work out by hand.
          assert True, "This prints if this assert fails 2 (also good for debugging!)"


      """

  Scenario: Agent implements decimal_to_binary so all tests pass
    Given an agent is tasked with implementing the decimal_to_binary function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
