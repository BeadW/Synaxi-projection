Feature: MBPP/72 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def dif_Square(n):
          pass

      === test_solution.py ===
      from solution import dif_Square


      def test_mbpp():
          assert dif_Square(5) == True
          assert dif_Square(10) == False
          assert dif_Square(15) == True

      """

  Scenario: Agent implements dif_Square so all pytest tests pass
    Given an agent is tasked with implementing the dif_Square function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
