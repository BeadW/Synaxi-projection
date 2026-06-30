Feature: MBPP/450 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def extract_string(str, l):
          pass

      === test_solution.py ===
      from solution import extract_string


      def test_mbpp():
          assert extract_string(['Python', 'list', 'exercises', 'practice', 'solution'] ,8)==['practice', 'solution']
          assert extract_string(['Python', 'list', 'exercises', 'practice', 'solution'] ,6)==['Python']
          assert extract_string(['Python', 'list', 'exercises', 'practice', 'solution'] ,9)==['exercises']

      """

  Scenario: Agent implements extract_string so all pytest tests pass
    Given an agent is tasked with implementing the extract_string function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
