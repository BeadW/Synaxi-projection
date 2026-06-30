Feature: MBPP/394 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def check_distinct(test_tup):
          pass

      === test_solution.py ===
      from solution import check_distinct


      def test_mbpp():
          assert check_distinct((1, 4, 5, 6, 1, 4)) == False
          assert check_distinct((1, 4, 5, 6)) == True
          assert check_distinct((2, 3, 4, 5, 6)) == True

      """

  Scenario: Agent implements check_distinct so all pytest tests pass
    Given an agent is tasked with implementing the check_distinct function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
