Feature: MBPP/83 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def get_Char(strr):
          pass

      === test_solution.py ===
      from solution import get_Char


      def test_mbpp():
          assert get_Char("abc") == "f"
          assert get_Char("gfg") == "t"
          assert get_Char("ab") == "c"

      """

  Scenario: Agent implements get_Char so all pytest tests pass
    Given an agent is tasked with implementing the get_Char function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
