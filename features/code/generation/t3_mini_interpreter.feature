Feature: Generate a mini expression interpreter
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === test_interpreter.py ===
      import pytest
      from interpreter import evaluate

      def test_integers():
          assert evaluate("42") == 42
          assert evaluate("0") == 0
          assert evaluate("-7") == -7

      def test_addition():
          assert evaluate("1 + 2") == 3
          assert evaluate("10 + 20 + 5") == 35

      def test_subtraction():
          assert evaluate("10 - 3") == 7
          assert evaluate("5 - 10") == -5

      def test_multiplication():
          assert evaluate("3 * 4") == 12
          assert evaluate("2 * 3 * 4") == 24

      def test_division():
          assert evaluate("10 / 2") == 5.0
          assert evaluate("7 / 2") == 3.5

      def test_precedence():
          assert evaluate("2 + 3 * 4") == 14
          assert evaluate("10 - 2 * 3") == 4

      def test_parentheses():
          assert evaluate("(2 + 3) * 4") == 20
          assert evaluate("(10 - 2) * (3 + 1)") == 32
          assert evaluate("((2 + 3))") == 5

      def test_mixed():
          assert evaluate("2 * (3 + 4) - 1") == 13
          assert evaluate("(1 + 2) * (3 + 4) / 7") == 3.0

      def test_division_by_zero():
          with pytest.raises(ZeroDivisionError):
              evaluate("1 / 0")

      def test_invalid_expression():
          with pytest.raises(Exception):
              evaluate("2 +")
      """

  Scenario: Agent implements the interpreter so all tests pass
    Given an agent is tasked with implementing interpreter.py with an evaluate(expr) function so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
