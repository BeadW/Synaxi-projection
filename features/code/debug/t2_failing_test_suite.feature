Feature: Fix a module so its test suite passes
  Complexity: T2
  Category: code/debug
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === calculator.py ===
      def add(a, b):
          return a - b

      def subtract(a, b):
          return a + b

      def multiply(a, b):
          result = a * b

      def divide(a, b):
          return a // b
      === test_calculator.py ===
      from calculator import add, subtract, multiply, divide

      def test_add():
          assert add(2, 3) == 5
          assert add(-1, 1) == 0
          assert add(0, 0) == 0

      def test_subtract():
          assert subtract(5, 3) == 2
          assert subtract(0, 5) == -5

      def test_multiply():
          assert multiply(3, 4) == 12
          assert multiply(-2, 5) == -10
          assert multiply(0, 100) == 0

      def test_divide():
          assert divide(10, 2) == 5.0
          assert divide(7, 2) == 3.5
      """

  Scenario: Agent fixes all bugs so pytest passes
    Given an agent is tasked with making all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
