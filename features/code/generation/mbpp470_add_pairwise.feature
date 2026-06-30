Feature: MBPP/470 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def add_pairwise(test_tup):
          pass

      === test_solution.py ===
      from solution import add_pairwise


      def test_mbpp():
          assert add_pairwise((1, 5, 7, 8, 10)) == (6, 12, 15, 18)
          assert add_pairwise((2, 6, 8, 9, 11)) == (8, 14, 17, 20)
          assert add_pairwise((3, 7, 9, 10, 12)) == (10, 16, 19, 22)

      """

  Scenario: Agent implements add_pairwise so all pytest tests pass
    Given an agent is tasked with implementing the add_pairwise function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
