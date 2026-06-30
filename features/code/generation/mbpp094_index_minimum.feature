Feature: MBPP/94 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def index_minimum():
          pass

      === test_solution.py ===
      from solution import index_minimum


      def test_mbpp():
          assert index_minimum([('Rash', 143), ('Manjeet', 200), ('Varsha', 100)]) == 'Varsha'
          assert index_minimum([('Yash', 185), ('Dawood', 125), ('Sanya', 175)]) == 'Dawood'
          assert index_minimum([('Sai', 345), ('Salman', 145), ('Ayesha', 96)]) == 'Ayesha'

      """

  Scenario: Agent implements index_minimum so all pytest tests pass
    Given an agent is tasked with implementing the index_minimum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
