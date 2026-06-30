Feature: MBPP/240 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def replace_list(list1,list2):
          pass

      === test_solution.py ===
      from solution import replace_list


      def test_mbpp():
          assert replace_list([1, 3, 5, 7, 9, 10],[2, 4, 6, 8])==[1, 3, 5, 7, 9, 2, 4, 6, 8]
          assert replace_list([1,2,3,4,5],[5,6,7,8])==[1,2,3,4,5,6,7,8]
          assert replace_list(["red","blue","green"],["yellow"])==["red","blue","yellow"]

      """

  Scenario: Agent implements replace_list so all pytest tests pass
    Given an agent is tasked with implementing the replace_list function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
