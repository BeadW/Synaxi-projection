Feature: HumanEval/44 — implement change_base
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def change_base(x: int, base: int):
          '''Change numerical base of input number x to base.
          return string representation after the conversion.
          base numbers are less than 10.
          >>> change_base(8, 3)
          '22'
          >>> change_base(8, 2)
          '1000'
          >>> change_base(7, 2)
          '111'
          '''
          pass

      === test_solution.py ===
      from solution import change_base


      def test_humaneval():
          assert change_base(8, 3) == "22"
          assert change_base(9, 3) == "100"
          assert change_base(234, 2) == "11101010"
          assert change_base(16, 2) == "10000"
          assert change_base(8, 2) == "1000"
          assert change_base(7, 2) == "111"
          for x in range(2, 8):
              assert change_base(x, x + 1) == str(x)


      """

  Scenario: Agent implements change_base so all tests pass
    Given an agent is tasked with implementing the change_base function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
