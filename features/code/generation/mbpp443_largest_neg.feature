Feature: MBPP/443 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def largest_neg(list1):
          pass

      === test_solution.py ===
      from solution import largest_neg


      def test_mbpp():
          assert largest_neg([1,2,3,-4,-6]) == -6
          assert largest_neg([1,2,3,-8,-9]) == -9
          assert largest_neg([1,2,3,4,-1]) == -1

      """

  Scenario: Agent implements largest_neg so all pytest tests pass
    Given an agent is tasked with implementing the largest_neg function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
