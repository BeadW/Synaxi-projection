Feature: MBPP/69 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def is_sublist(l, s):
          pass

      === test_solution.py ===
      from solution import is_sublist


      def test_mbpp():
          assert is_sublist([2,4,3,5,7],[3,7])==False
          assert is_sublist([2,4,3,5,7],[4,3])==True
          assert is_sublist([2,4,3,5,7],[1,6])==False

      """

  Scenario: Agent implements is_sublist so all pytest tests pass
    Given an agent is tasked with implementing the is_sublist function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
