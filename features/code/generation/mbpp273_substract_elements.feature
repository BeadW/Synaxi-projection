Feature: MBPP/273 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def substract_elements(test_tup1, test_tup2):
          pass

      === test_solution.py ===
      from solution import substract_elements


      def test_mbpp():
          assert substract_elements((10, 4, 5), (2, 5, 18)) == (8, -1, -13)
          assert substract_elements((11, 2, 3), (24, 45 ,16)) == (-13, -43, -13)
          assert substract_elements((7, 18, 9), (10, 11, 12)) == (-3, 7, -3)

      """

  Scenario: Agent implements substract_elements so all pytest tests pass
    Given an agent is tasked with implementing the substract_elements function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
