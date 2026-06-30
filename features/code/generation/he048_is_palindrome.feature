Feature: HumanEval/48 — implement is_palindrome
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def is_palindrome(text: str):
          '''
          Checks if given string is a palindrome
          >>> is_palindrome('')
          True
          >>> is_palindrome('aba')
          True
          >>> is_palindrome('aaaaa')
          True
          >>> is_palindrome('zbcd')
          False
          '''
          pass

      === test_solution.py ===
      from solution import is_palindrome


      def test_humaneval():
          assert is_palindrome('') == True
          assert is_palindrome('aba') == True
          assert is_palindrome('aaaaa') == True
          assert is_palindrome('zbcd') == False
          assert is_palindrome('xywyx') == True
          assert is_palindrome('xywyz') == False
          assert is_palindrome('xywzx') == False


      """

  Scenario: Agent implements is_palindrome so all tests pass
    Given an agent is tasked with implementing the is_palindrome function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
