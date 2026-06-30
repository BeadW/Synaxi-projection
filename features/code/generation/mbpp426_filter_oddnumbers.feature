Feature: MBPP/426 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def filter_oddnumbers(nums):
          pass

      === test_solution.py ===
      from solution import filter_oddnumbers


      def test_mbpp():
          assert filter_oddnumbers([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])==[1,3,5,7,9]
          assert filter_oddnumbers([10,20,45,67,84,93])==[45,67,93]
          assert filter_oddnumbers([5,7,9,8,6,4,3])==[5,7,9,3]

      """

  Scenario: Agent implements filter_oddnumbers so all pytest tests pass
    Given an agent is tasked with implementing the filter_oddnumbers function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
