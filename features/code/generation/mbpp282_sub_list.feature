Feature: MBPP/282 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def sub_list(nums1,nums2):
          pass

      === test_solution.py ===
      from solution import sub_list


      def test_mbpp():
          assert sub_list([1, 2, 3],[4,5,6])==[-3,-3,-3]
          assert sub_list([1,2],[3,4])==[-2,-2]
          assert sub_list([90,120],[50,70])==[40,50]

      """

  Scenario: Agent implements sub_list so all pytest tests pass
    Given an agent is tasked with implementing the sub_list function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
