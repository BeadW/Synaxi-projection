Feature: MBPP/261 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def division_elements(test_tup1, test_tup2):
          pass

      === test_solution.py ===
      from solution import division_elements


      def test_mbpp():
          assert division_elements((10, 4, 6, 9),(5, 2, 3, 3)) == (2, 2, 2, 3)
          assert division_elements((12, 6, 8, 16),(6, 3, 4, 4)) == (2, 2, 2, 4)
          assert division_elements((20, 14, 36, 18),(5, 7, 6, 9)) == (4, 2, 6, 2)

      """

  Scenario: Agent implements division_elements so all pytest tests pass
    Given an agent is tasked with implementing the division_elements function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
