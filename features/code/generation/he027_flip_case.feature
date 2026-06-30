Feature: HumanEval/27 — implement flip_case
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def flip_case(string: str) -> str:
          ''' For a given string, flip lowercase characters to uppercase and uppercase to lowercase.
          >>> flip_case('Hello')
          'hELLO'
          '''
          pass

      === test_solution.py ===
      from solution import flip_case


      def test_humaneval():
          assert flip_case('') == ''
          assert flip_case('Hello!') == 'hELLO!'
          assert flip_case('These violent delights have violent ends') == 'tHESE VIOLENT DELIGHTS HAVE VIOLENT ENDS'

      """

  Scenario: Agent implements flip_case so all tests pass
    Given an agent is tasked with implementing the flip_case function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
