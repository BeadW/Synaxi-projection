Feature: MBPP/95 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def Find_Min_Length(lst):
          pass

      === test_solution.py ===
      from solution import Find_Min_Length


      def test_mbpp():
          assert Find_Min_Length([[1],[1,2]]) == 1
          assert Find_Min_Length([[1,2],[1,2,3],[1,2,3,4]]) == 2
          assert Find_Min_Length([[3,3,3],[4,4,4,4]]) == 3

      """

  Scenario: Agent implements Find_Min_Length so all pytest tests pass
    Given an agent is tasked with implementing the Find_Min_Length function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
