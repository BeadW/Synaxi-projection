Feature: HumanEval/25 — implement factorize
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List


      def factorize(n: int) -> List[int]:
          ''' Return list of prime factors of given integer in the order from smallest to largest.
          Each of the factors should be listed number of times corresponding to how many times it appeares in factorization.
          Input number should be equal to the product of all factors
          >>> factorize(8)
          [2, 2, 2]
          >>> factorize(25)
          [5, 5]
          >>> factorize(70)
          [2, 5, 7]
          '''
          pass

      === test_solution.py ===
      from solution import factorize


      def test_humaneval():
          assert factorize(2) == [2]
          assert factorize(4) == [2, 2]
          assert factorize(8) == [2, 2, 2]
          assert factorize(3 * 19) == [3, 19]
          assert factorize(3 * 19 * 3 * 19) == [3, 3, 19, 19]
          assert factorize(3 * 19 * 3 * 19 * 3 * 19) == [3, 3, 3, 19, 19, 19]
          assert factorize(3 * 19 * 19 * 19) == [3, 19, 19, 19]
          assert factorize(3 * 2 * 3) == [2, 3, 3]

      """

  Scenario: Agent implements factorize so all tests pass
    Given an agent is tasked with implementing the factorize function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
