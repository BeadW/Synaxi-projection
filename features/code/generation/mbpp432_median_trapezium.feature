Feature: MBPP/432 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def median_trapezium(base1,base2,height):
          pass

      === test_solution.py ===
      from solution import median_trapezium


      def test_mbpp():
          assert median_trapezium(15,25,35)==20
          assert median_trapezium(10,20,30)==15
          assert median_trapezium(6,9,4)==7.5

      """

  Scenario: Agent implements median_trapezium so all pytest tests pass
    Given an agent is tasked with implementing the median_trapezium function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
