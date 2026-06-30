Feature: MBPP/414 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def overlapping(list1,list2):
          pass

      === test_solution.py ===
      from solution import overlapping


      def test_mbpp():
          assert overlapping([1,2,3,4,5],[6,7,8,9]) == False
          assert overlapping([1,2,3],[4,5,6]) == False
          assert overlapping([1,4,5],[1,4,5]) == True

      """

  Scenario: Agent implements overlapping so all pytest tests pass
    Given an agent is tasked with implementing the overlapping function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
