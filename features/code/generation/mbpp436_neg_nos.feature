Feature: MBPP/436 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def neg_nos(list1):
          pass

      === test_solution.py ===
      from solution import neg_nos


      def test_mbpp():
          assert neg_nos([-1,4,5,-6]) == [-1,-6]
          assert neg_nos([-1,-2,3,4]) == [-1,-2]
          assert neg_nos([-7,-6,8,9]) == [-7,-6]

      """

  Scenario: Agent implements neg_nos so all pytest tests pass
    Given an agent is tasked with implementing the neg_nos function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
