Feature: MBPP/477 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def is_lower(string):
          pass

      === test_solution.py ===
      from solution import is_lower


      def test_mbpp():
          assert is_lower("InValid") == "invalid"
          assert is_lower("TruE") == "true"
          assert is_lower("SenTenCE") == "sentence"

      """

  Scenario: Agent implements is_lower so all pytest tests pass
    Given an agent is tasked with implementing the is_lower function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
