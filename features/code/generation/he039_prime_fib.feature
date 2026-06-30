Feature: HumanEval/39 — implement prime_fib
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def prime_fib(n: int):
          '''
          prime_fib returns n-th number that is a Fibonacci number and it's also prime.
          >>> prime_fib(1)
          2
          >>> prime_fib(2)
          3
          >>> prime_fib(3)
          5
          >>> prime_fib(4)
          13
          >>> prime_fib(5)
          89
          '''
          pass

      === test_solution.py ===
      from solution import prime_fib


      def test_humaneval():
          assert prime_fib(1) == 2
          assert prime_fib(2) == 3
          assert prime_fib(3) == 5
          assert prime_fib(4) == 13
          assert prime_fib(5) == 89
          assert prime_fib(6) == 233
          assert prime_fib(7) == 1597
          assert prime_fib(8) == 28657
          assert prime_fib(9) == 514229
          assert prime_fib(10) == 433494437


      """

  Scenario: Agent implements prime_fib so all tests pass
    Given an agent is tasked with implementing the prime_fib function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
