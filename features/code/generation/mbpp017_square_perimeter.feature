Feature: MBPP/17 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def square_perimeter(a):
          pass

      === test_solution.py ===
      from solution import square_perimeter


      def test_mbpp():
          assert square_perimeter(10)==40
          assert square_perimeter(5)==20
          assert square_perimeter(4)==16

      """

  Scenario: Agent implements square_perimeter so all pytest tests pass
    Given an agent is tasked with implementing the square_perimeter function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
