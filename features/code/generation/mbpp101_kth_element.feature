Feature: MBPP/101 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def kth_element(arr, k):
          pass

      === test_solution.py ===
      from solution import kth_element


      def test_mbpp():
          assert kth_element([12,3,5,7,19], 2) == 3
          assert kth_element([17,24,8,23], 3) == 8
          assert kth_element([16,21,25,36,4], 4) == 36

      """

  Scenario: Agent implements kth_element so all pytest tests pass
    Given an agent is tasked with implementing the kth_element function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
