Feature: MBPP/253 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def count_integer(list1):
          pass

      === test_solution.py ===
      from solution import count_integer


      def test_mbpp():
          assert count_integer([1,2,'abc',1.2]) == 2
          assert count_integer([1,2,3]) == 3
          assert count_integer([1,1.2,4,5.1]) == 2

      """

  Scenario: Agent implements count_integer so all pytest tests pass
    Given an agent is tasked with implementing the count_integer function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
