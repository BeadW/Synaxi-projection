Feature: HumanEval/62 — implement derivative
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def derivative(xs: list):
          ''' xs represent coefficients of a polynomial.
          xs[0] + xs[1] * x + xs[2] * x^2 + ....
           Return derivative of this polynomial in the same form.
          >>> derivative([3, 1, 2, 4, 5])
          [1, 4, 12, 20]
          >>> derivative([1, 2, 3])
          [2, 6]
          '''
          pass

      === test_solution.py ===
      from solution import derivative


      def test_humaneval():
          assert derivative([3, 1, 2, 4, 5]) == [1, 4, 12, 20]
          assert derivative([1, 2, 3]) == [2, 6]
          assert derivative([3, 2, 1]) == [2, 2]
          assert derivative([3, 2, 1, 0, 4]) == [2, 2, 0, 16]
          assert derivative([1]) == []


      """

  Scenario: Agent implements derivative so all tests pass
    Given an agent is tasked with implementing the derivative function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
