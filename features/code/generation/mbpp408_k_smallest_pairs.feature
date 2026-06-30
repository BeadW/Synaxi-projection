Feature: MBPP/408 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def k_smallest_pairs():
          pass

      === test_solution.py ===
      from solution import k_smallest_pairs


      def test_mbpp():
          assert k_smallest_pairs([1,3,7],[2,4,6],2)==[[1, 2], [1, 4]]
          assert k_smallest_pairs([1,3,7],[2,4,6],1)==[[1, 2]]
          assert k_smallest_pairs([1,3,7],[2,4,6],7)==[[1, 2], [1, 4], [3, 2], [1, 6], [3, 4], [3, 6], [7, 2]]

      """

  Scenario: Agent implements k_smallest_pairs so all pytest tests pass
    Given an agent is tasked with implementing the k_smallest_pairs function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
