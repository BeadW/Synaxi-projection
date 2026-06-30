Feature: HumanEval/59 — implement largest_prime_factor
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def largest_prime_factor(n: int):
          '''Return the largest prime factor of n. Assume n > 1 and is not a prime.
          >>> largest_prime_factor(13195)
          29
          >>> largest_prime_factor(2048)
          2
          '''
          pass

      === test_solution.py ===
      from solution import largest_prime_factor


      def test_humaneval():
          assert largest_prime_factor(15) == 5
          assert largest_prime_factor(27) == 3
          assert largest_prime_factor(63) == 7
          assert largest_prime_factor(330) == 11
          assert largest_prime_factor(13195) == 29


      """

  Scenario: Agent implements largest_prime_factor so all tests pass
    Given an agent is tasked with implementing the largest_prime_factor function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
