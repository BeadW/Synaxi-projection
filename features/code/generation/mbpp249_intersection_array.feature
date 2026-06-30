Feature: MBPP/249 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def intersection_array(array_nums1,array_nums2):
          pass

      === test_solution.py ===
      from solution import intersection_array


      def test_mbpp():
          assert intersection_array([1, 2, 3, 5, 7, 8, 9, 10],[1, 2, 4, 8, 9])==[1, 2, 8, 9]
          assert intersection_array([1, 2, 3, 5, 7, 8, 9, 10],[3,5,7,9])==[3,5,7,9]
          assert intersection_array([1, 2, 3, 5, 7, 8, 9, 10],[10,20,30,40])==[10]

      """

  Scenario: Agent implements intersection_array so all pytest tests pass
    Given an agent is tasked with implementing the intersection_array function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
