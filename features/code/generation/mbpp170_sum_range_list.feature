Feature: MBPP/170 — 
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def sum_range_list(list1, m, n):
          pass

      === test_solution.py ===
      from solution import sum_range_list


      def test_mbpp():
          assert sum_range_list([2,1,5,6,8,3,4,9,10,11,8,12], 8, 10) == 29
          assert sum_range_list([2,1,5,6,8,3,4,9,10,11,8,12], 5, 7) == 16
          assert sum_range_list([2,1,5,6,8,3,4,9,10,11,8,12], 7, 10) == 38

      """

  Scenario: Agent implements sum_range_list so all pytest tests pass
    Given an agent is tasked with implementing the sum_range_list function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
