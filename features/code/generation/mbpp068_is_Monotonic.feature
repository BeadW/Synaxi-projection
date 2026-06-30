Feature: MBPP/68 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def is_Monotonic(A):
          pass

      === test_solution.py ===
      from solution import is_Monotonic


      def test_mbpp():
          assert is_Monotonic([6, 5, 4, 4]) == True
          assert is_Monotonic([1, 2, 2, 3]) == True
          assert is_Monotonic([1, 3, 2]) == False

      """

  Scenario: Agent implements is_Monotonic so all pytest tests pass
    Given an agent is tasked with implementing the is_Monotonic function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
