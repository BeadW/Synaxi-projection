Feature: MBPP/278 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def count_first_elements(test_tup):
          pass

      === test_solution.py ===
      from solution import count_first_elements


      def test_mbpp():
          assert count_first_elements((1, 5, 7, (4, 6), 10) ) == 3
          assert count_first_elements((2, 9, (5, 7), 11) ) == 2
          assert count_first_elements((11, 15, 5, 8, (2, 3), 8) ) == 4

      """

  Scenario: Agent implements count_first_elements so all pytest tests pass
    Given an agent is tasked with implementing the count_first_elements function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
