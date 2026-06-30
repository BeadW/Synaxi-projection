Feature: MBPP/473 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def tuple_intersection(test_list1, test_list2):
          pass

      === test_solution.py ===
      from solution import tuple_intersection


      def test_mbpp():
          assert tuple_intersection([(3, 4), (5, 6), (9, 10), (4, 5)] , [(5, 4), (3, 4), (6, 5), (9, 11)]) == {(4, 5), (3, 4), (5, 6)}
          assert tuple_intersection([(4, 1), (7, 4), (11, 13), (17, 14)] , [(1, 4), (7, 4), (16, 12), (10, 13)]) == {(4, 7), (1, 4)}
          assert tuple_intersection([(2, 1), (3, 2), (1, 3), (1, 4)] , [(11, 2), (2, 3), (6, 2), (1, 3)]) == {(1, 3), (2, 3)}

      """

  Scenario: Agent implements tuple_intersection so all pytest tests pass
    Given an agent is tasked with implementing the tuple_intersection function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
