Feature: MBPP/66 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def pos_count(list):
          pass

      === test_solution.py ===
      from solution import pos_count


      def test_mbpp():
          assert pos_count([1,-2,3,-4]) == 2
          assert pos_count([3,4,5,-1]) == 3
          assert pos_count([1,2,3,4]) == 4

      """

  Scenario: Agent implements pos_count so all pytest tests pass
    Given an agent is tasked with implementing the pos_count function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
