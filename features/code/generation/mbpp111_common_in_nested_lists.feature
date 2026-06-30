Feature: MBPP/111 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def common_in_nested_lists(nestedlist):
          pass

      === test_solution.py ===
      from solution import common_in_nested_lists


      def test_mbpp():
          assert set(common_in_nested_lists([[12, 18, 23, 25, 45], [7, 12, 18, 24, 28], [1, 5, 8, 12, 15, 16, 18]]))==set([18, 12])
          assert set(common_in_nested_lists([[12, 5, 23, 25, 45], [7, 11, 5, 23, 28], [1, 5, 8, 18, 23, 16]]))==set([5,23])
          assert set(common_in_nested_lists([[2, 3,4, 1], [4, 5], [6,4, 8],[4, 5], [6, 8,4]]))==set([4])

      """

  Scenario: Agent implements common_in_nested_lists so all pytest tests pass
    Given an agent is tasked with implementing the common_in_nested_lists function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
