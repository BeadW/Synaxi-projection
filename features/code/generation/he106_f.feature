Feature: HumanEval/106 — implement f
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def f(n):
          ''' Implement the function f that takes n as a parameter,
          and returns a list of size n, such that the value of the element at index i is the factorial of i if i is even
          or the sum of numbers from 1 to i otherwise.
          i starts from 1.
          the factorial of i is the multiplication of the numbers from 1 to i (1 * 2 * ... * i).
          Example:
          f(5) == [1, 2, 6, 24, 15]
          '''
          pass

      === test_solution.py ===
      from solution import f


      def test_humaneval():

          assert f(5) == [1, 2, 6, 24, 15]
          assert f(7) == [1, 2, 6, 24, 15, 720, 28]
          assert f(1) == [1]
          assert f(3) == [1, 2, 6]

      """

  Scenario: Agent implements f so all tests pass
    Given an agent is tasked with implementing the f function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
