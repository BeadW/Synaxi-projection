Feature: MBPP/65 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def recursive_list_sum(data_list):
          pass

      === test_solution.py ===
      from solution import recursive_list_sum


      def test_mbpp():
          assert recursive_list_sum(([1, 2, [3,4],[5,6]]))==21
          assert recursive_list_sum(([7, 10, [15,14],[19,41]]))==106
          assert recursive_list_sum(([10, 20, [30,40],[50,60]]))==210

      """

  Scenario: Agent implements recursive_list_sum so all pytest tests pass
    Given an agent is tasked with implementing the recursive_list_sum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
