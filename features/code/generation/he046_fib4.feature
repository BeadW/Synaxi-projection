Feature: HumanEval/46 — implement fib4
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def fib4(n: int):
          '''The Fib4 number sequence is a sequence similar to the Fibbonacci sequnece that's defined as follows:
          fib4(0) -> 0
          fib4(1) -> 0
          fib4(2) -> 2
          fib4(3) -> 0
          fib4(n) -> fib4(n-1) + fib4(n-2) + fib4(n-3) + fib4(n-4).
          Please write a function to efficiently compute the n-th element of the fib4 number sequence.  Do not use recursion.
          >>> fib4(5)
          4
          >>> fib4(6)
          8
          >>> fib4(7)
          14
          '''
          pass

      === test_solution.py ===
      from solution import fib4


      def test_humaneval():
          assert fib4(5) == 4
          assert fib4(8) == 28
          assert fib4(10) == 104
          assert fib4(12) == 386


      """

  Scenario: Agent implements fib4 so all tests pass
    Given an agent is tasked with implementing the fib4 function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
