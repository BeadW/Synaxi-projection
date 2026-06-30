Feature: MBPP/280 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def sequential_search(dlist, item):
          pass

      === test_solution.py ===
      from solution import sequential_search


      def test_mbpp():
          assert sequential_search([11,23,58,31,56,77,43,12,65,19],31) == (True, 3)
          assert sequential_search([12, 32, 45, 62, 35, 47, 44, 61],61) == (True, 7)
          assert sequential_search([9, 10, 17, 19, 22, 39, 48, 56],48) == (True, 6)

      """

  Scenario: Agent implements sequential_search so all pytest tests pass
    Given an agent is tasked with implementing the sequential_search function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
