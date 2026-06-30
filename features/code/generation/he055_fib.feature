Feature: HumanEval/55 — implement fib
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def fib(n: int):
          '''Return n-th Fibonacci number.
          >>> fib(10)
          55
          >>> fib(1)
          1
          >>> fib(8)
          21
          '''
          pass

      === test_solution.py ===
      from solution import fib


      def test_humaneval():
          assert fib(10) == 55
          assert fib(1) == 1
          assert fib(8) == 21
          assert fib(11) == 89
          assert fib(12) == 144


      """

  Scenario: Agent implements fib so all tests pass
    Given an agent is tasked with implementing the fib function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
