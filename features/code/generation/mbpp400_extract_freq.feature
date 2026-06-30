Feature: MBPP/400 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def extract_freq(test_list):
          pass

      === test_solution.py ===
      from solution import extract_freq


      def test_mbpp():
          assert extract_freq([(3, 4), (1, 2), (4, 3), (5, 6)] ) == 3
          assert extract_freq([(4, 15), (2, 3), (5, 4), (6, 7)] ) == 4
          assert extract_freq([(5, 16), (2, 3), (6, 5), (6, 9)] ) == 4

      """

  Scenario: Agent implements extract_freq so all pytest tests pass
    Given an agent is tasked with implementing the extract_freq function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
