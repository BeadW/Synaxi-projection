Feature: HumanEval/119 — implement match_parens
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def match_parens(lst):
          '''
          You are given a list of two strings, both strings consist of open
          parentheses '(' or close parentheses ')' only.
          Your job is to check if it is possible to concatenate the two strings in
          some order, that the resulting string will be good.
          A string S is considered to be good if and only if all parentheses in S
          are balanced. For example: the string '(())()' is good, while the string
          '())' is not.
          Return 'Yes' if there's a way to make a good string, and return 'No' otherwise.

          Examples:
          match_parens(['()(', ')']) == 'Yes'
          match_parens([')', ')']) == 'No'
          '''
          pass

      === test_solution.py ===
      from solution import match_parens


      def test_humaneval():

          # Check some simple cases
          assert match_parens(['()(', ')']) == 'Yes'
          assert match_parens([')', ')']) == 'No'
          assert match_parens(['(()(())', '())())']) == 'No'
          assert match_parens([')())', '(()()(']) == 'Yes'
          assert match_parens(['(())))', '(()())((']) == 'Yes'
          assert match_parens(['()', '())']) == 'No'
          assert match_parens(['(()(', '()))()']) == 'Yes'
          assert match_parens(['((((', '((())']) == 'No'
          assert match_parens([')(()', '(()(']) == 'No'
          assert match_parens([')(', ')(']) == 'No'


          # Check some edge cases that are easy to work out by hand.
          assert match_parens(['(', ')']) == 'Yes'
          assert match_parens([')', '(']) == 'Yes' 


      """

  Scenario: Agent implements match_parens so all tests pass
    Given an agent is tasked with implementing the match_parens function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
