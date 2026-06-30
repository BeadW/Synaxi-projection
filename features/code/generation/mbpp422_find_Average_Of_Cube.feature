Feature: MBPP/422 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def find_Average_Of_Cube(n):
          pass

      === test_solution.py ===
      from solution import find_Average_Of_Cube


      def test_mbpp():
          assert find_Average_Of_Cube(2) == 4.5
          assert find_Average_Of_Cube(3) == 12
          assert find_Average_Of_Cube(1) == 1

      """

  Scenario: Agent implements find_Average_Of_Cube so all pytest tests pass
    Given an agent is tasked with implementing the find_Average_Of_Cube function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
