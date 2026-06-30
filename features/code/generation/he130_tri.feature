Feature: HumanEval/130 — implement tri
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def tri(n):
          '''Everyone knows Fibonacci sequence, it was studied deeply by mathematicians in 
          the last couple centuries. However, what people don't know is Tribonacci sequence.
          Tribonacci sequence is defined by the recurrence:
          tri(1) = 3
          tri(n) = 1 + n / 2, if n is even.
          tri(n) =  tri(n - 1) + tri(n - 2) + tri(n + 1), if n is odd.
          For example:
          tri(2) = 1 + (2 / 2) = 2
          tri(4) = 3
          tri(3) = tri(2) + tri(1) + tri(4)
                 = 2 + 3 + 3 = 8 
          You are given a non-negative integer number n, you have to a return a list of the 
          first n + 1 numbers of the Tribonacci sequence.
          Examples:
          tri(3) = [1, 3, 2, 8]
          '''
          pass

      === test_solution.py ===
      from solution import tri


      def test_humaneval():

          # Check some simple cases

          assert tri(3) == [1, 3, 2.0, 8.0]
          assert tri(4) == [1, 3, 2.0, 8.0, 3.0]
          assert tri(5) == [1, 3, 2.0, 8.0, 3.0, 15.0]
          assert tri(6) == [1, 3, 2.0, 8.0, 3.0, 15.0, 4.0]
          assert tri(7) == [1, 3, 2.0, 8.0, 3.0, 15.0, 4.0, 24.0]
          assert tri(8) == [1, 3, 2.0, 8.0, 3.0, 15.0, 4.0, 24.0, 5.0]
          assert tri(9) == [1, 3, 2.0, 8.0, 3.0, 15.0, 4.0, 24.0, 5.0, 35.0]
          assert tri(20) == [1, 3, 2.0, 8.0, 3.0, 15.0, 4.0, 24.0, 5.0, 35.0, 6.0, 48.0, 7.0, 63.0, 8.0, 80.0, 9.0, 99.0, 10.0, 120.0, 11.0]

          # Check some edge cases that are easy to work out by hand.
          assert tri(0) == [1]
          assert tri(1) == [1, 3]

      """

  Scenario: Agent implements tri so all tests pass
    Given an agent is tasked with implementing the tri function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
