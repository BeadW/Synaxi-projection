Feature: HumanEval/10 — implement make_palindrome
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def is_palindrome(string: str) -> bool:
          ''' Test if given string is a palindrome '''
          return string == string[::-1]


      def make_palindrome(string: str) -> str:
          ''' Find the shortest palindrome that begins with a supplied string.
          Algorithm idea is simple:
          - Find the longest postfix of supplied string that is a palindrome.
          - Append to the end of the string reverse of a string prefix that comes before the palindromic suffix.
          >>> make_palindrome('')
          ''
          >>> make_palindrome('cat')
          'catac'
          >>> make_palindrome('cata')
          'catac'
          '''
          pass

      === test_solution.py ===
      from solution import make_palindrome


      def test_humaneval():
          assert make_palindrome('') == ''
          assert make_palindrome('x') == 'x'
          assert make_palindrome('xyz') == 'xyzyx'
          assert make_palindrome('xyx') == 'xyx'
          assert make_palindrome('jerry') == 'jerryrrej'

      """

  Scenario: Agent implements make_palindrome so all tests pass
    Given an agent is tasked with implementing the make_palindrome function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
