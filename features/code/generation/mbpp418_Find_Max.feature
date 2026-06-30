Feature: MBPP/418 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def Find_Max(lst):
          pass

      === test_solution.py ===
      from solution import Find_Max


      def test_mbpp():
          assert Find_Max([['A'],['A','B'],['A','B','C']]) == ['A','B','C']
          assert Find_Max([[1],[1,2],[1,2,3]]) == [1,2,3]
          assert Find_Max([[1,1],[1,2,3],[1,5,6,1]]) == [1,5,6,1]

      """

  Scenario: Agent implements Find_Max so all pytest tests pass
    Given an agent is tasked with implementing the Find_Max function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
