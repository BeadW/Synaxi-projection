Feature: MBPP/130 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def max_occurrences():
          pass

      === test_solution.py ===
      from solution import max_occurrences


      def test_mbpp():
          assert max_occurrences([2,3,8,4,7,9,8,2,6,5,1,6,1,2,3,2,4,6,9,1,2])==2
          assert max_occurrences([2,3,8,4,7,9,8,7,9,15,14,10,12,13,16,18])==8
          assert max_occurrences([10,20,20,30,40,90,80,50,30,20,50,10])==20

      """

  Scenario: Agent implements max_occurrences so all pytest tests pass
    Given an agent is tasked with implementing the max_occurrences function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
