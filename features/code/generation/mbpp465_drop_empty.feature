Feature: MBPP/465 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def drop_empty(dict1):
          pass

      === test_solution.py ===
      from solution import drop_empty


      def test_mbpp():
          assert drop_empty({'c1': 'Red', 'c2': 'Green', 'c3':None})=={'c1': 'Red', 'c2': 'Green'}
          assert drop_empty({'c1': 'Red', 'c2': None, 'c3':None})=={'c1': 'Red'}
          assert drop_empty({'c1': None, 'c2': 'Green', 'c3':None})=={ 'c2': 'Green'}

      """

  Scenario: Agent implements drop_empty so all pytest tests pass
    Given an agent is tasked with implementing the drop_empty function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
