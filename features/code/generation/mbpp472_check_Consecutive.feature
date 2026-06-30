Feature: MBPP/472 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def check_Consecutive(l):
          pass

      === test_solution.py ===
      from solution import check_Consecutive


      def test_mbpp():
          assert check_Consecutive([1,2,3,4,5]) == True
          assert check_Consecutive([1,2,3,5,6]) == False
          assert check_Consecutive([1,2,1]) == False

      """

  Scenario: Agent implements check_Consecutive so all pytest tests pass
    Given an agent is tasked with implementing the check_Consecutive function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
