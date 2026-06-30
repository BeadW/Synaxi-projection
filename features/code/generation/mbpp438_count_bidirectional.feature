Feature: MBPP/438 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def count_bidirectional(test_list):
          pass

      === test_solution.py ===
      from solution import count_bidirectional


      def test_mbpp():
          assert count_bidirectional([(5, 6), (1, 2), (6, 5), (9, 1), (6, 5), (2, 1)] ) == 3
          assert count_bidirectional([(5, 6), (1, 3), (6, 5), (9, 1), (6, 5), (2, 1)] ) == 2
          assert count_bidirectional([(5, 6), (1, 2), (6, 5), (9, 2), (6, 5), (2, 1)] ) == 4

      """

  Scenario: Agent implements count_bidirectional so all pytest tests pass
    Given an agent is tasked with implementing the count_bidirectional function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
