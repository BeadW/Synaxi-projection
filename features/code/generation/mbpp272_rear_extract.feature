Feature: MBPP/272 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def rear_extract(test_list):
          pass

      === test_solution.py ===
      from solution import rear_extract


      def test_mbpp():
          assert rear_extract([(1, 'Rash', 21), (2, 'Varsha', 20), (3, 'Kil', 19)]) == [21, 20, 19]
          assert rear_extract([(1, 'Sai', 36), (2, 'Ayesha', 25), (3, 'Salman', 45)]) == [36, 25, 45]
          assert rear_extract([(1, 'Sudeep', 14), (2, 'Vandana', 36), (3, 'Dawood', 56)]) == [14, 36, 56]

      """

  Scenario: Agent implements rear_extract so all pytest tests pass
    Given an agent is tasked with implementing the rear_extract function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
