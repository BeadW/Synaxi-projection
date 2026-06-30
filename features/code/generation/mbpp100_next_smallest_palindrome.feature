Feature: MBPP/100 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def next_smallest_palindrome():
          pass

      === test_solution.py ===
      from solution import next_smallest_palindrome


      def test_mbpp():
          assert next_smallest_palindrome(99)==101
          assert next_smallest_palindrome(1221)==1331
          assert next_smallest_palindrome(120)==121

      """

  Scenario: Agent implements next_smallest_palindrome so all pytest tests pass
    Given an agent is tasked with implementing the next_smallest_palindrome function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
