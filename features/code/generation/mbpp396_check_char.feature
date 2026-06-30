Feature: MBPP/396 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def check_char():
          pass

      === test_solution.py ===
      from solution import check_char


      def test_mbpp():
          assert check_char("abba") == "Valid"
          assert check_char("a") == "Valid"
          assert check_char("abcd") == "Invalid"

      """

  Scenario: Agent implements check_char so all pytest tests pass
    Given an agent is tasked with implementing the check_char function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
