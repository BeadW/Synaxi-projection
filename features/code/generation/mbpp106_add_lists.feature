Feature: MBPP/106 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def add_lists(test_list, test_tup):
          pass

      === test_solution.py ===
      from solution import add_lists


      def test_mbpp():
          assert add_lists([5, 6, 7], (9, 10)) == (9, 10, 5, 6, 7)
          assert add_lists([6, 7, 8], (10, 11)) == (10, 11, 6, 7, 8)
          assert add_lists([7, 8, 9], (11, 12)) == (11, 12, 7, 8, 9)

      """

  Scenario: Agent implements add_lists so all pytest tests pass
    Given an agent is tasked with implementing the add_lists function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
