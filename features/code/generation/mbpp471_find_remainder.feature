Feature: MBPP/471 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def find_remainder(arr, n):
          pass

      === test_solution.py ===
      from solution import find_remainder


      def test_mbpp():
          assert find_remainder([ 100, 10, 5, 25, 35, 14 ],11) ==9
          assert find_remainder([1,1,1],1) == 0
          assert find_remainder([1,2,1],2) == 0

      """

  Scenario: Agent implements find_remainder so all pytest tests pass
    Given an agent is tasked with implementing the find_remainder function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
