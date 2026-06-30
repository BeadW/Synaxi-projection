Feature: MBPP/171 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def perimeter_pentagon():
          pass

      === test_solution.py ===
      from solution import perimeter_pentagon


      def test_mbpp():
          assert perimeter_pentagon(5) == 25
          assert perimeter_pentagon(10) == 50
          assert perimeter_pentagon(15) == 75

      """

  Scenario: Agent implements perimeter_pentagon so all pytest tests pass
    Given an agent is tasked with implementing the perimeter_pentagon function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
