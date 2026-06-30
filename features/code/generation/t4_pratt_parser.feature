Feature: Implement a Pratt parser for math expressions with variables and functions
  Complexity: T4
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === parser.py ===
      '''
      Pratt (top-down operator precedence) parser for arithmetic expressions.

      Supported:
        - Integer and float literals
        - Named variables (looked up in env dict)
        - Unary minus: -x
        - Binary ops: + - * / ** (right-associative) % (mod)
        - Parentheses for grouping
        - Built-in functions: abs(x), min(x,y), max(x,y), round(x)
        - Comparison ops: == != < <= > >= (return 1 or 0)

      Entry point:
          evaluate(expr: str, env: dict = None) -> float | int
      '''

      def evaluate(expr: str, env: dict = None) -> float:
          pass

      === test_parser.py ===
      import pytest
      from parser import evaluate

      def test_integer_literal():
          assert evaluate('42') == 42

      def test_float_literal():
          assert abs(evaluate('3.14') - 3.14) < 1e-9

      def test_addition():
          assert evaluate('1 + 2') == 3

      def test_subtraction():
          assert evaluate('10 - 3') == 7

      def test_multiplication():
          assert evaluate('4 * 5') == 20

      def test_division():
          assert abs(evaluate('7 / 2') - 3.5) < 1e-9

      def test_modulo():
          assert evaluate('10 % 3') == 1

      def test_power_right_assoc():
          # 2**3**2 should be 2**(3**2) = 512, not (2**3)**2 = 64
          assert evaluate('2 ** 3 ** 2') == 512

      def test_precedence_mul_over_add():
          assert evaluate('2 + 3 * 4') == 14

      def test_precedence_power_over_mul():
          assert evaluate('2 * 3 ** 2') == 18

      def test_unary_minus():
          assert evaluate('-5') == -5

      def test_unary_minus_in_expr():
          assert evaluate('10 + -3') == 7

      def test_parentheses():
          assert evaluate('(2 + 3) * 4') == 20

      def test_nested_parens():
          assert evaluate('((2 + 3) * (4 - 1)) / 5') == 3.0

      def test_variable_lookup():
          assert evaluate('x + 1', {'x': 10}) == 11

      def test_multiple_variables():
          assert evaluate('a * b + c', {'a': 2, 'b': 3, 'c': 4}) == 10

      def test_variable_in_power():
          assert evaluate('2 ** n', {'n': 8}) == 256

      def test_abs_function():
          assert evaluate('abs(-7)') == 7

      def test_min_function():
          assert evaluate('min(3, 5)') == 3

      def test_max_function():
          assert evaluate('max(3, 5)') == 5

      def test_round_function():
          assert evaluate('round(3.7)') == 4

      def test_nested_function_calls():
          assert evaluate('max(abs(-3), min(10, 4))') == 4

      def test_function_with_expr_args():
          assert evaluate('max(2 * 3, 4 + 1)') == 6

      def test_comparison_equal():
          assert evaluate('3 == 3') == 1
          assert evaluate('3 == 4') == 0

      def test_comparison_less_than():
          assert evaluate('2 < 5') == 1
          assert evaluate('5 < 2') == 0

      def test_comparison_in_expr():
          assert evaluate('(x > 0) * x', {'x': 5}) == 5
          assert evaluate('(x > 0) * x', {'x': -3}) == 0

      def test_complex_expression():
          env = {'x': 3, 'y': 4}
          # Pythagorean: sqrt not supported, but x**2 + y**2
          assert evaluate('x ** 2 + y ** 2', env) == 25

      def test_whitespace_handling():
          assert evaluate('  2  +  3  ') == 5

      def test_zero_division_raises():
          with pytest.raises((ZeroDivisionError, ValueError)):
              evaluate('1 / 0')

      def test_unknown_variable_raises():
          with pytest.raises((KeyError, NameError, ValueError)):
              evaluate('z + 1', {})
      """

  Scenario: Agent implements a Pratt parser so all tests pass
    Given an agent is tasked with implementing a Pratt (top-down operator precedence) parser in parser.py with an evaluate(expr, env) entry point supporting literals, variables, unary minus, binary operators with correct precedence and right-associativity for **, parentheses, built-in functions, and comparison operators so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
