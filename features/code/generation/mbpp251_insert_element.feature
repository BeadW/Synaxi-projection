Feature: MBPP/251 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def insert_element(list,element):
          pass

      === test_solution.py ===
      from solution import insert_element


      def test_mbpp():
          assert insert_element(['Red', 'Green', 'Black'] ,'c')==['c', 'Red', 'c', 'Green', 'c', 'Black']
          assert insert_element(['python', 'java'] ,'program')==['program', 'python', 'program', 'java']
          assert insert_element(['happy', 'sad'] ,'laugh')==['laugh', 'happy', 'laugh', 'sad']

      """

  Scenario: Agent implements insert_element so all pytest tests pass
    Given an agent is tasked with implementing the insert_element function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
