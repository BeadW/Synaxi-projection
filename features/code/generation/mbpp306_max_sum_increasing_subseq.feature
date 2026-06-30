Feature: MBPP/306 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def max_sum_increasing_subseq(a, n, index, k):
          pass

      === test_solution.py ===
      from solution import max_sum_increasing_subseq


      def test_mbpp():
          assert max_sum_increasing_subseq([1, 101, 2, 3, 100, 4, 5 ], 7, 4, 6) == 11
          assert max_sum_increasing_subseq([1, 101, 2, 3, 100, 4, 5 ], 7, 2, 5) == 7
          assert max_sum_increasing_subseq([11, 15, 19, 21, 26, 28, 31], 7, 2, 4) == 71

      """

  Scenario: Agent implements max_sum_increasing_subseq so all pytest tests pass
    Given an agent is tasked with implementing the max_sum_increasing_subseq function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
