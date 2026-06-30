Feature: HumanEval/36 — implement fizz_buzz
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def fizz_buzz(n: int):
          '''Return the number of times the digit 7 appears in integers less than n which are divisible by 11 or 13.
          >>> fizz_buzz(50)
          0
          >>> fizz_buzz(78)
          2
          >>> fizz_buzz(79)
          3
          '''
          pass

      === test_solution.py ===
      from solution import fizz_buzz


      def test_humaneval():
          assert fizz_buzz(50) == 0
          assert fizz_buzz(78) == 2
          assert fizz_buzz(79) == 3
          assert fizz_buzz(100) == 3
          assert fizz_buzz(200) == 6
          assert fizz_buzz(4000) == 192
          assert fizz_buzz(10000) == 639
          assert fizz_buzz(100000) == 8026


      """

  Scenario: Agent implements fizz_buzz so all tests pass
    Given an agent is tasked with implementing the fizz_buzz function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
