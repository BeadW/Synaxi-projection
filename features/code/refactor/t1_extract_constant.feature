Feature: Extract a magic number into a named constant
  Complexity: T1
  Category: code/refactor

  Background:
    Given the following Python code:
      """
      def calculate_discount(price):
          return price * 0.15

      def apply_tax(price):
          return price + price * 0.15
      """

  Scenario: Agent extracts 0.15 into a named constant used in both functions
    Given an agent is tasked with refactoring to extract 0.15 into a named constant
    When the agent completes the task
    Then the output contains the text "0.15" exactly once
    And the code execution script passes:
      """
      assert abs(calculate_discount(100) - 15.0) < 0.001
      assert abs(apply_tax(100) - 115.0) < 0.001
      """
