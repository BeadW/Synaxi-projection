Feature: HumanEval/131 — implement digits
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def digits(n):
          '''Given a positive integer n, return the product of the odd digits.
          Return 0 if all digits are even.
          For example:
          digits(1)  == 1
          digits(4)  == 0
          digits(235) == 15
          '''
          pass

      === test_solution.py ===
      from solution import digits


      def test_humaneval():

          # Check some simple cases
          assert digits(5) == 5
          assert digits(54) == 5
          assert digits(120) ==1
          assert digits(5014) == 5
          assert digits(98765) == 315
          assert digits(5576543) == 2625

          # Check some edge cases that are easy to work out by hand.
          assert digits(2468) == 0


      """

  Scenario: Agent implements digits so all tests pass
    Given an agent is tasked with implementing the digits function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
