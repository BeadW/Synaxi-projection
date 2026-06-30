Feature: MBPP/113 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def check_integer(text):
          pass

      === test_solution.py ===
      from solution import check_integer


      def test_mbpp():
          assert check_integer("python")==False
          assert check_integer("1")==True
          assert check_integer("12345")==True

      """

  Scenario: Agent implements check_integer so all pytest tests pass
    Given an agent is tasked with implementing the check_integer function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
