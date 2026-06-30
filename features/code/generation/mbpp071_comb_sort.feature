Feature: MBPP/71 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def comb_sort(nums):
          pass

      === test_solution.py ===
      from solution import comb_sort


      def test_mbpp():
          assert comb_sort([5, 15, 37, 25, 79]) == [5, 15, 25, 37, 79]
          assert comb_sort([41, 32, 15, 19, 22]) == [15, 19, 22, 32, 41]
          assert comb_sort([99, 15, 13, 47]) == [13, 15, 47, 99]

      """

  Scenario: Agent implements comb_sort so all pytest tests pass
    Given an agent is tasked with implementing the comb_sort function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
