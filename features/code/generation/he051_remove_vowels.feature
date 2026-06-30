Feature: HumanEval/51 — implement remove_vowels
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def remove_vowels(text):
          '''
          remove_vowels is a function that takes string and returns string without vowels.
          >>> remove_vowels('')
          ''
          >>> remove_vowels("abcdef\nghijklm")
          'bcdf\nghjklm'
          >>> remove_vowels('abcdef')
          'bcdf'
          >>> remove_vowels('aaaaa')
          ''
          >>> remove_vowels('aaBAA')
          'B'
          >>> remove_vowels('zbcd')
          'zbcd'
          '''
          pass

      === test_solution.py ===
      from solution import remove_vowels


      def test_humaneval():
          assert remove_vowels('') == ''
          assert remove_vowels("abcdef\nghijklm") == 'bcdf\nghjklm'
          assert remove_vowels('fedcba') == 'fdcb'
          assert remove_vowels('eeeee') == ''
          assert remove_vowels('acBAA') == 'cB'
          assert remove_vowels('EcBOO') == 'cB'
          assert remove_vowels('ybcd') == 'ybcd'


      """

  Scenario: Agent implements remove_vowels so all tests pass
    Given an agent is tasked with implementing the remove_vowels function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
