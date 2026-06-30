Feature: MBPP/291 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def count_no_of_ways(n, k):
          pass

      === test_solution.py ===
      from solution import count_no_of_ways


      def test_mbpp():
          assert count_no_of_ways(2, 4) == 16
          assert count_no_of_ways(3, 2) == 6
          assert count_no_of_ways(4, 4) == 228

      """

  Scenario: Agent implements count_no_of_ways so all pytest tests pass
    Given an agent is tasked with implementing the count_no_of_ways function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
