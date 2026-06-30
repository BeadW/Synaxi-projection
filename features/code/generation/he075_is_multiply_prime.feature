Feature: HumanEval/75 — implement is_multiply_prime
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def is_multiply_prime(a):
          '''Write a function that returns true if the given number is the multiplication of 3 prime numbers
          and false otherwise.
          Knowing that (a) is less then 100. 
          Example:
          is_multiply_prime(30) == True
          30 = 2 * 3 * 5
          '''
          pass

      === test_solution.py ===
      from solution import is_multiply_prime


      def test_humaneval():

          assert is_multiply_prime(5) == False
          assert is_multiply_prime(30) == True
          assert is_multiply_prime(8) == True
          assert is_multiply_prime(10) == False
          assert is_multiply_prime(125) == True
          assert is_multiply_prime(3 * 5 * 7) == True
          assert is_multiply_prime(3 * 6 * 7) == False
          assert is_multiply_prime(9 * 9 * 9) == False
          assert is_multiply_prime(11 * 9 * 9) == False
          assert is_multiply_prime(11 * 13 * 7) == True


      """

  Scenario: Agent implements is_multiply_prime so all tests pass
    Given an agent is tasked with implementing the is_multiply_prime function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
