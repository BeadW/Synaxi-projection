Feature: HumanEval/63 — implement fibfib
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def fibfib(n: int):
          '''The FibFib number sequence is a sequence similar to the Fibbonacci sequnece that's defined as follows:
          fibfib(0) == 0
          fibfib(1) == 0
          fibfib(2) == 1
          fibfib(n) == fibfib(n-1) + fibfib(n-2) + fibfib(n-3).
          Please write a function to efficiently compute the n-th element of the fibfib number sequence.
          >>> fibfib(1)
          0
          >>> fibfib(5)
          4
          >>> fibfib(8)
          24
          '''
          pass

      === test_solution.py ===
      from solution import fibfib


      def test_humaneval():
          assert fibfib(2) == 1
          assert fibfib(1) == 0
          assert fibfib(5) == 4
          assert fibfib(8) == 24
          assert fibfib(10) == 81
          assert fibfib(12) == 274
          assert fibfib(14) == 927


      """

  Scenario: Agent implements fibfib so all tests pass
    Given an agent is tasked with implementing the fibfib function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
