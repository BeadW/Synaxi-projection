Feature: MBPP/70 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def find_equal_tuple(Input):
          pass

      === test_solution.py ===
      from solution import find_equal_tuple


      def test_mbpp():
          assert get_equal([(11, 22, 33), (44, 55, 66)]) == True
          assert get_equal([(1, 2, 3), (4, 5, 6, 7)]) == False
          assert get_equal([(1, 2), (3, 4)]) == True

      """

  Scenario: Agent implements find_equal_tuple so all pytest tests pass
    Given an agent is tasked with implementing the find_equal_tuple function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
