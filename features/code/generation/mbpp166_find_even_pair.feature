Feature: MBPP/166 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def find_even_pair(A):
          pass

      === test_solution.py ===
      from solution import find_even_pair


      def test_mbpp():
          assert find_even_pair([5, 4, 7, 2, 1]) == 4
          assert find_even_pair([7, 2, 8, 1, 0, 5, 11]) == 9
          assert find_even_pair([1, 2, 3]) == 1

      """

  Scenario: Agent implements find_even_pair so all pytest tests pass
    Given an agent is tasked with implementing the find_even_pair function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
