Feature: MBPP/222 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def check_type(test_tuple):
          pass

      === test_solution.py ===
      from solution import check_type


      def test_mbpp():
          assert check_type((5, 6, 7, 3, 5, 6) ) == True
          assert check_type((1, 2, "4") ) == False
          assert check_type((3, 2, 1, 4, 5) ) == True

      """

  Scenario: Agent implements check_type so all pytest tests pass
    Given an agent is tasked with implementing the check_type function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
