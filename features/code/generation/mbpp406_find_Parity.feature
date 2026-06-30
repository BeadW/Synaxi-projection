Feature: MBPP/406 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def find_Parity(x):
          pass

      === test_solution.py ===
      from solution import find_Parity


      def test_mbpp():
          assert find_Parity(12) == False
          assert find_Parity(7) == True
          assert find_Parity(10) == False

      """

  Scenario: Agent implements find_Parity so all pytest tests pass
    Given an agent is tasked with implementing the find_Parity function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
