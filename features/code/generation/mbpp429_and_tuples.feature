Feature: MBPP/429 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def and_tuples(test_tup1, test_tup2):
          pass

      === test_solution.py ===
      from solution import and_tuples


      def test_mbpp():
          assert and_tuples((10, 4, 6, 9), (5, 2, 3, 3)) == (0, 0, 2, 1)
          assert and_tuples((1, 2, 3, 4), (5, 6, 7, 8)) == (1, 2, 3, 0)
          assert and_tuples((8, 9, 11, 12), (7, 13, 14, 17)) == (0, 9, 10, 0)

      """

  Scenario: Agent implements and_tuples so all pytest tests pass
    Given an agent is tasked with implementing the and_tuples function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
