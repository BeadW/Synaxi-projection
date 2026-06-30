Feature: HumanEval/31 — implement is_prime
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def is_prime(n):
          '''Return true if a given number is prime, and false otherwise.
          >>> is_prime(6)
          False
          >>> is_prime(101)
          True
          >>> is_prime(11)
          True
          >>> is_prime(13441)
          True
          >>> is_prime(61)
          True
          >>> is_prime(4)
          False
          >>> is_prime(1)
          False
          '''
          pass

      === test_solution.py ===
      from solution import is_prime


      def test_humaneval():
          assert is_prime(6) == False
          assert is_prime(101) == True
          assert is_prime(11) == True
          assert is_prime(13441) == True
          assert is_prime(61) == True
          assert is_prime(4) == False
          assert is_prime(1) == False
          assert is_prime(5) == True
          assert is_prime(11) == True
          assert is_prime(17) == True
          assert is_prime(5 * 17) == False
          assert is_prime(11 * 7) == False
          assert is_prime(13441 * 19) == False


      """

  Scenario: Agent implements is_prime so all tests pass
    Given an agent is tasked with implementing the is_prime function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
