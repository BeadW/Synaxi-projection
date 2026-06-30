Feature: MBPP/286 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def max_sub_array_sum_repeated(a, n, k):
          pass

      === test_solution.py ===
      from solution import max_sub_array_sum_repeated


      def test_mbpp():
          assert max_sub_array_sum_repeated([10, 20, -30, -1], 4, 3) == 30
          assert max_sub_array_sum_repeated([-1, 10, 20], 3, 2) == 59
          assert max_sub_array_sum_repeated([-1, -2, -3], 3, 3) == -1

      """

  Scenario: Agent implements max_sub_array_sum_repeated so all pytest tests pass
    Given an agent is tasked with implementing the max_sub_array_sum_repeated function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
