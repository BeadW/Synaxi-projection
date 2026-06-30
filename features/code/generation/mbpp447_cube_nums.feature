Feature: MBPP/447 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def cube_nums(nums):
          pass

      === test_solution.py ===
      from solution import cube_nums


      def test_mbpp():
          assert cube_nums([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])==[1, 8, 27, 64, 125, 216, 343, 512, 729, 1000]
          assert cube_nums([10,20,30])==([1000, 8000, 27000])
          assert cube_nums([12,15])==([1728, 3375])

      """

  Scenario: Agent implements cube_nums so all pytest tests pass
    Given an agent is tasked with implementing the cube_nums function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
