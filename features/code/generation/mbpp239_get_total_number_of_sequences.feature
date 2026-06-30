Feature: MBPP/239 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def get_total_number_of_sequences(m,n):
          pass

      === test_solution.py ===
      from solution import get_total_number_of_sequences


      def test_mbpp():
          assert get_total_number_of_sequences(10, 4) == 4
          assert get_total_number_of_sequences(5, 2) == 6
          assert get_total_number_of_sequences(16, 3) == 84

      """

  Scenario: Agent implements get_total_number_of_sequences so all pytest tests pass
    Given an agent is tasked with implementing the get_total_number_of_sequences function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
