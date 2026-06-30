Feature: HumanEval/2 — implement truncate_number
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def truncate_number(number: float) -> float:
          ''' Given a positive floating point number, it can be decomposed into
          and integer part (largest integer smaller than given number) and decimals
          (leftover part always smaller than 1).

          Return the decimal part of the number.
          >>> truncate_number(3.5)
          0.5
          '''
          pass

      === test_solution.py ===
      from solution import truncate_number


      def test_humaneval():
          assert truncate_number(3.5) == 0.5
          assert abs(truncate_number(1.33) - 0.33) < 1e-6
          assert abs(truncate_number(123.456) - 0.456) < 1e-6

      """

  Scenario: Agent implements truncate_number so all tests pass
    Given an agent is tasked with implementing the truncate_number function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
