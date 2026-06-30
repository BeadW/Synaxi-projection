Feature: Fix a function that returns None instead of a value
  Complexity: T1
  Category: code/debug

  Background:
    Given the following broken Python code:
      """
      def multiply(a, b):
          result = a * b
      """

  Scenario: Agent produces code that returns the correct value
    Given an agent is tasked with fixing the bug
    When the agent completes the task
    Then running multiply(3, 4) returns 12
    And running multiply(0, 99) returns 0
    And running multiply(-2, 5) returns -10
