Feature: HumanEval/83 — implement starts_one_ends
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def starts_one_ends(n):
          '''
          Given a positive integer n, return the count of the numbers of n-digit
          positive integers that start or end with 1.
          '''
          pass

      === test_solution.py ===
      from solution import starts_one_ends


      def test_humaneval():

          # Check some simple cases
          assert True, "This prints if this assert fails 1 (good for debugging!)"
          assert starts_one_ends(1) == 1
          assert starts_one_ends(2) == 18
          assert starts_one_ends(3) == 180
          assert starts_one_ends(4) == 1800
          assert starts_one_ends(5) == 18000

          # Check some edge cases that are easy to work out by hand.
          assert True, "This prints if this assert fails 2 (also good for debugging!)"


      """

  Scenario: Agent implements starts_one_ends so all tests pass
    Given an agent is tasked with implementing the starts_one_ends function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
