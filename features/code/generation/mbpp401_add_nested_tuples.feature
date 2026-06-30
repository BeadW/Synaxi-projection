Feature: MBPP/401 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def add_nested_tuples(test_tup1, test_tup2):
          pass

      === test_solution.py ===
      from solution import add_nested_tuples


      def test_mbpp():
          assert add_nested_tuples(((1, 3), (4, 5), (2, 9), (1, 10)), ((6, 7), (3, 9), (1, 1), (7, 3))) == ((7, 10), (7, 14), (3, 10), (8, 13))
          assert add_nested_tuples(((2, 4), (5, 6), (3, 10), (2, 11)), ((7, 8), (4, 10), (2, 2), (8, 4))) == ((9, 12), (9, 16), (5, 12), (10, 15))
          assert add_nested_tuples(((3, 5), (6, 7), (4, 11), (3, 12)), ((8, 9), (5, 11), (3, 3), (9, 5))) == ((11, 14), (11, 18), (7, 14), (12, 17))

      """

  Scenario: Agent implements add_nested_tuples so all pytest tests pass
    Given an agent is tasked with implementing the add_nested_tuples function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
