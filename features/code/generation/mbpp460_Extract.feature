Feature: MBPP/460 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def Extract(lst):
          pass

      === test_solution.py ===
      from solution import Extract


      def test_mbpp():
          assert Extract([[1, 2], [3, 4, 5], [6, 7, 8, 9]]) == [1, 3, 6]
          assert Extract([[1,2,3],[4, 5]]) == [1,4]
          assert Extract([[9,8,1],[1,2]]) == [9,1]

      """

  Scenario: Agent implements Extract so all pytest tests pass
    Given an agent is tasked with implementing the Extract function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
