Feature: MBPP/270 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def sum_even_and_even_index(arr):
          pass

      === test_solution.py ===
      from solution import sum_even_and_even_index


      def test_mbpp():
          assert sum_even_and_even_index([5, 6, 12, 1, 18, 8]) == 30
          assert sum_even_and_even_index([3, 20, 17, 9, 2, 10, 18, 13, 6, 18]) == 26
          assert sum_even_and_even_index([5, 6, 12, 1]) == 12

      """

  Scenario: Agent implements sum_even_and_even_index so all pytest tests pass
    Given an agent is tasked with implementing the sum_even_and_even_index function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
