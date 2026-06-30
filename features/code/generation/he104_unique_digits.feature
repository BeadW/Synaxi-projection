Feature: HumanEval/104 — implement unique_digits
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def unique_digits(x):
          '''Given a list of positive integers x. return a sorted list of all 
          elements that hasn't any even digit.

          Note: Returned list should be sorted in increasing order.
    
          For example:
          >>> unique_digits([15, 33, 1422, 1])
          [1, 15, 33]
          >>> unique_digits([152, 323, 1422, 10])
          []
          '''
          pass

      === test_solution.py ===
      from solution import unique_digits


      def test_humaneval():

          # Check some simple cases
          assert unique_digits([15, 33, 1422, 1]) == [1, 15, 33]
          assert unique_digits([152, 323, 1422, 10]) == []
          assert unique_digits([12345, 2033, 111, 151]) == [111, 151]
          assert unique_digits([135, 103, 31]) == [31, 135]

          # Check some edge cases that are easy to work out by hand.
          assert True


      """

  Scenario: Agent implements unique_digits so all tests pass
    Given an agent is tasked with implementing the unique_digits function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
