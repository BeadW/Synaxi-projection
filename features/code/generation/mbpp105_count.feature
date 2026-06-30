Feature: MBPP/105 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def count(lst):
          pass

      === test_solution.py ===
      from solution import count


      def test_mbpp():
          assert count([True,False,True]) == 2
          assert count([False,False]) == 0
          assert count([True,True,True]) == 3

      """

  Scenario: Agent implements count so all pytest tests pass
    Given an agent is tasked with implementing the count function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
