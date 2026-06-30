Feature: MBPP/135 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def hexagonal_num(n):
          pass

      === test_solution.py ===
      from solution import hexagonal_num


      def test_mbpp():
          assert hexagonal_num(10) == 190
          assert hexagonal_num(5) == 45
          assert hexagonal_num(7) == 91

      """

  Scenario: Agent implements hexagonal_num so all pytest tests pass
    Given an agent is tasked with implementing the hexagonal_num function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
