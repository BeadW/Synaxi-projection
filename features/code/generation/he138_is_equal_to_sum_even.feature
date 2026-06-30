Feature: HumanEval/138 — implement is_equal_to_sum_even
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def is_equal_to_sum_even(n):
          '''Evaluate whether the given number n can be written as the sum of exactly 4 positive even numbers
          Example
          is_equal_to_sum_even(4) == False
          is_equal_to_sum_even(6) == False
          is_equal_to_sum_even(8) == True
          '''
          pass

      === test_solution.py ===
      from solution import is_equal_to_sum_even


      def test_humaneval():
          assert is_equal_to_sum_even(4) == False
          assert is_equal_to_sum_even(6) == False
          assert is_equal_to_sum_even(8) == True
          assert is_equal_to_sum_even(10) == True
          assert is_equal_to_sum_even(11) == False
          assert is_equal_to_sum_even(12) == True
          assert is_equal_to_sum_even(13) == False
          assert is_equal_to_sum_even(16) == True

      """

  Scenario: Agent implements is_equal_to_sum_even so all tests pass
    Given an agent is tasked with implementing the is_equal_to_sum_even function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
