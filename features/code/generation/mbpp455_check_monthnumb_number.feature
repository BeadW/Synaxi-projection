Feature: MBPP/455 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def check_monthnumb_number(monthnum2):
          pass

      === test_solution.py ===
      from solution import check_monthnumb_number


      def test_mbpp():
          assert check_monthnumb_number(5)==True
          assert check_monthnumb_number(2)==False
          assert check_monthnumb_number(6)==False

      """

  Scenario: Agent implements check_monthnumb_number so all pytest tests pass
    Given an agent is tasked with implementing the check_monthnumb_number function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
