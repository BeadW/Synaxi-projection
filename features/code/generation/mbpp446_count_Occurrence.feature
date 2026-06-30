Feature: MBPP/446 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def count_Occurrence():
          pass

      === test_solution.py ===
      from solution import count_Occurrence


      def test_mbpp():
          assert count_Occurrence(('a', 'a', 'c', 'b', 'd'),['a', 'b'] ) == 3
          assert count_Occurrence((1, 2, 3, 1, 4, 6, 7, 1, 4),[1, 4, 7]) == 6
          assert count_Occurrence((1,2,3,4,5,6),[1,2]) == 2

      """

  Scenario: Agent implements count_Occurrence so all pytest tests pass
    Given an agent is tasked with implementing the count_Occurrence function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
