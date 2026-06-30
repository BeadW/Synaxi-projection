Feature: HumanEval/24 — implement largest_divisor
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def largest_divisor(n: int) -> int:
          ''' For a given number n, find the largest number that divides n evenly, smaller than n
          >>> largest_divisor(15)
          5
          '''
          pass

      === test_solution.py ===
      from solution import largest_divisor


      def test_humaneval():
          assert largest_divisor(3) == 1
          assert largest_divisor(7) == 1
          assert largest_divisor(10) == 5
          assert largest_divisor(100) == 50
          assert largest_divisor(49) == 7

      """

  Scenario: Agent implements largest_divisor so all tests pass
    Given an agent is tasked with implementing the largest_divisor function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
