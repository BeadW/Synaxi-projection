Feature: Fix a missing base case in a recursive function
  Complexity: T2
  Category: code/debug

  Background:
    Given the following broken Python code:
      """
      def factorial(n):
          return n * factorial(n - 1)
      """

  Scenario: Agent produces code that handles base cases correctly
    Given an agent is tasked with fixing the bug
    When the agent completes the task
    Then running factorial(0) returns 1
    And running factorial(1) returns 1
    And running factorial(5) returns 120
    And running factorial(10) returns 3628800
