Feature: HumanEval/6 — implement parse_nested_parens
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List


      def parse_nested_parens(paren_string: str) -> List[int]:
          ''' Input to this function is a string represented multiple groups for nested parentheses separated by spaces.
          For each of the group, output the deepest level of nesting of parentheses.
          E.g. (()()) has maximum two levels of nesting while ((())) has three.

          >>> parse_nested_parens('(()()) ((())) () ((())()())')
          [2, 3, 1, 3]
          '''
          pass

      === test_solution.py ===
      from solution import parse_nested_parens


      def test_humaneval():
          assert parse_nested_parens('(()()) ((())) () ((())()())') == [2, 3, 1, 3]
          assert parse_nested_parens('() (()) ((())) (((())))') == [1, 2, 3, 4]
          assert parse_nested_parens('(()(())((())))') == [4]

      """

  Scenario: Agent implements parse_nested_parens so all tests pass
    Given an agent is tasked with implementing the parse_nested_parens function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
