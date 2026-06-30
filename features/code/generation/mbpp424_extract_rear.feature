Feature: MBPP/424 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def extract_rear(test_tuple):
          pass

      === test_solution.py ===
      from solution import extract_rear


      def test_mbpp():
          assert extract_rear(('Mers', 'for', 'Vers') ) == ['s', 'r', 's']
          assert extract_rear(('Avenge', 'for', 'People') ) == ['e', 'r', 'e']
          assert extract_rear(('Gotta', 'get', 'go') ) == ['a', 't', 'o']

      """

  Scenario: Agent implements extract_rear so all pytest tests pass
    Given an agent is tasked with implementing the extract_rear function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
