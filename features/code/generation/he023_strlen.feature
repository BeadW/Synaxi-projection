Feature: HumanEval/23 — implement strlen
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def strlen(string: str) -> int:
          ''' Return length of given string
          >>> strlen('')
          0
          >>> strlen('abc')
          3
          '''
          pass

      === test_solution.py ===
      from solution import strlen


      def test_humaneval():
          assert strlen('') == 0
          assert strlen('x') == 1
          assert strlen('asdasnakj') == 9

      """

  Scenario: Agent implements strlen so all tests pass
    Given an agent is tasked with implementing the strlen function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
