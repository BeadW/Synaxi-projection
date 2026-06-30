Feature: MBPP/405 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def check_tuplex(tuplex,tuple1):
          pass

      === test_solution.py ===
      from solution import check_tuplex


      def test_mbpp():
          assert check_tuplex(("w", 3, "r", "e", "s", "o", "u", "r", "c", "e"),'r')==True
          assert check_tuplex(("w", 3, "r", "e", "s", "o", "u", "r", "c", "e"),'5')==False
          assert check_tuplex(("w", 3, "r", "e", "s", "o", "u", "r", "c","e"),3)==True

      """

  Scenario: Agent implements check_tuplex so all pytest tests pass
    Given an agent is tasked with implementing the check_tuplex function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
