Feature: HumanEval/1 — implement separate_paren_groups
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List


      def separate_paren_groups(paren_string: str) -> List[str]:
          ''' Input to this function is a string containing multiple groups of nested parentheses. Your goal is to
          separate those group into separate strings and return the list of those.
          Separate groups are balanced (each open brace is properly closed) and not nested within each other
          Ignore any spaces in the input string.
          >>> separate_paren_groups('( ) (( )) (( )( ))')
          ['()', '(())', '(()())']
          '''
          pass

      === test_solution.py ===
      from solution import separate_paren_groups


      def test_humaneval():
          assert separate_paren_groups('(()()) ((())) () ((())()())') == [
              '(()())', '((()))', '()', '((())()())'
          ]
          assert separate_paren_groups('() (()) ((())) (((())))') == [
              '()', '(())', '((()))', '(((())))'
          ]
          assert separate_paren_groups('(()(())((())))') == [
              '(()(())((())))'
          ]
          assert separate_paren_groups('( ) (( )) (( )( ))') == ['()', '(())', '(()())']

      """

  Scenario: Agent implements separate_paren_groups so all tests pass
    Given an agent is tasked with implementing the separate_paren_groups function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
