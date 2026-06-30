Feature: MBPP/256 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def count_Primes_nums(n):
          pass

      === test_solution.py ===
      from solution import count_Primes_nums


      def test_mbpp():
          assert count_Primes_nums(5) == 2
          assert count_Primes_nums(10) == 4
          assert count_Primes_nums(100) == 25

      """

  Scenario: Agent implements count_Primes_nums so all pytest tests pass
    Given an agent is tasked with implementing the count_Primes_nums function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
