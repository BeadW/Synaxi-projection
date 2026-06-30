Feature: MBPP/457 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def Find_Min(lst):
          pass

      === test_solution.py ===
      from solution import Find_Min


      def test_mbpp():
          assert Find_Min([[1],[1,2],[1,2,3]]) == [1]
          assert Find_Min([[1,1],[1,1,1],[1,2,7,8]]) == [1,1]
          assert Find_Min([['x'],['x','y'],['x','y','z']]) == ['x']

      """

  Scenario: Agent implements Find_Min so all pytest tests pass
    Given an agent is tasked with implementing the Find_Min function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
