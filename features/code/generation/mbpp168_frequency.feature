Feature: MBPP/168 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def frequency(a,x):
          pass

      === test_solution.py ===
      from solution import frequency


      def test_mbpp():
          assert frequency([1,2,3], 4) == 0
          assert frequency([1,2,2,3,3,3,4], 3) == 3
          assert frequency([0,1,2,3,1,2], 1) == 2

      """

  Scenario: Agent implements frequency so all pytest tests pass
    Given an agent is tasked with implementing the frequency function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
