Feature: MBPP/92 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def is_undulating(n):
          pass

      === test_solution.py ===
      from solution import is_undulating


      def test_mbpp():
          assert is_undulating(1212121) == True
          assert is_undulating(1991) == False
          assert is_undulating(121) == True

      """

  Scenario: Agent implements is_undulating so all pytest tests pass
    Given an agent is tasked with implementing the is_undulating function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
