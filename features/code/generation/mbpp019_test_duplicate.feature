Feature: MBPP/19 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def test_duplicate(arraynums):
          pass

      === test_solution.py ===
      from solution import test_duplicate


      def test_mbpp():
          assert test_duplicate(([1,2,3,4,5]))==False
          assert test_duplicate(([1,2,3,4, 4]))==True
          assert test_duplicate([1,1,2,2,3,3,4,4,5])==True

      """

  Scenario: Agent implements test_duplicate so all pytest tests pass
    Given an agent is tasked with implementing the test_duplicate function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
