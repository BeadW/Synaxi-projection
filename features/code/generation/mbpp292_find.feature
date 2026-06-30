Feature: MBPP/292 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def find(n,m):
          pass

      === test_solution.py ===
      from solution import find


      def test_mbpp():
          assert find(10,3) == 3
          assert find(4,2) == 2
          assert find(20,5) == 4

      """

  Scenario: Agent implements find so all pytest tests pass
    Given an agent is tasked with implementing the find function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
