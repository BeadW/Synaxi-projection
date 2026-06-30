Feature: HumanEval/49 — implement modp
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def modp(n: int, p: int):
          '''Return 2^n modulo p (be aware of numerics).
          >>> modp(3, 5)
          3
          >>> modp(1101, 101)
          2
          >>> modp(0, 101)
          1
          >>> modp(3, 11)
          8
          >>> modp(100, 101)
          1
          '''
          pass

      === test_solution.py ===
      from solution import modp


      def test_humaneval():
          assert modp(3, 5) == 3
          assert modp(1101, 101) == 2
          assert modp(0, 101) == 1
          assert modp(3, 11) == 8
          assert modp(100, 101) == 1
          assert modp(30, 5) == 4
          assert modp(31, 5) == 3


      """

  Scenario: Agent implements modp so all tests pass
    Given an agent is tasked with implementing the modp function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
