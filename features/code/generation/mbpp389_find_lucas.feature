Feature: MBPP/389 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def find_lucas(n):
          pass

      === test_solution.py ===
      from solution import find_lucas


      def test_mbpp():
          assert find_lucas(9) == 76
          assert find_lucas(4) == 7
          assert find_lucas(3) == 4

      """

  Scenario: Agent implements find_lucas so all pytest tests pass
    Given an agent is tasked with implementing the find_lucas function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
