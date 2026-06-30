Feature: MBPP/77 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def is_Diff(n):
          pass

      === test_solution.py ===
      from solution import is_Diff


      def test_mbpp():
          assert is_Diff (12345) == False
          assert is_Diff(1212112) == True
          assert is_Diff(1212) == False

      """

  Scenario: Agent implements is_Diff so all pytest tests pass
    Given an agent is tasked with implementing the is_Diff function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
