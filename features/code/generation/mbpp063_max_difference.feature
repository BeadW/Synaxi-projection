Feature: MBPP/63 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def max_difference(test_list):
          pass

      === test_solution.py ===
      from solution import max_difference


      def test_mbpp():
          assert max_difference([(3, 5), (1, 7), (10, 3), (1, 2)]) == 7
          assert max_difference([(4, 6), (2, 17), (9, 13), (11, 12)]) == 15
          assert max_difference([(12, 35), (21, 27), (13, 23), (41, 22)]) == 23

      """

  Scenario: Agent implements max_difference so all pytest tests pass
    Given an agent is tasked with implementing the max_difference function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
