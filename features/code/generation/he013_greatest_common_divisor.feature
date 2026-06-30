Feature: HumanEval/13 — implement greatest_common_divisor
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def greatest_common_divisor(a: int, b: int) -> int:
          ''' Return a greatest common divisor of two integers a and b
          >>> greatest_common_divisor(3, 5)
          1
          >>> greatest_common_divisor(25, 15)
          5
          '''
          pass

      === test_solution.py ===
      from solution import greatest_common_divisor


      def test_humaneval():
          assert greatest_common_divisor(3, 7) == 1
          assert greatest_common_divisor(10, 15) == 5
          assert greatest_common_divisor(49, 14) == 7
          assert greatest_common_divisor(144, 60) == 12

      """

  Scenario: Agent implements greatest_common_divisor so all tests pass
    Given an agent is tasked with implementing the greatest_common_divisor function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
