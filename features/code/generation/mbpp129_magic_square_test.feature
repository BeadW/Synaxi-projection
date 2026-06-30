Feature: MBPP/129 — 
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def magic_square_test(my_matrix):
          pass

      === test_solution.py ===
      from solution import magic_square_test


      def test_mbpp():
          assert magic_square_test([[7, 12, 1, 14], [2, 13, 8, 11], [16, 3, 10, 5], [9, 6, 15, 4]])==True
          assert magic_square_test([[2, 7, 6], [9, 5, 1], [4, 3, 8]])==True
          assert magic_square_test([[2, 7, 6], [9, 5, 1], [4, 3, 7]])==False

      """

  Scenario: Agent implements magic_square_test so all pytest tests pass
    Given an agent is tasked with implementing the magic_square_test function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
