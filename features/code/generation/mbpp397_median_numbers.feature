Feature: MBPP/397 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def median_numbers(a,b,c):
          pass

      === test_solution.py ===
      from solution import median_numbers


      def test_mbpp():
          assert median_numbers(25,55,65)==55.0
          assert median_numbers(20,10,30)==20.0
          assert median_numbers(15,45,75)==45.0

      """

  Scenario: Agent implements median_numbers so all pytest tests pass
    Given an agent is tasked with implementing the median_numbers function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
