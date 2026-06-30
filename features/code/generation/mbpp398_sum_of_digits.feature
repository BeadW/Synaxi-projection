Feature: MBPP/398 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def sum_of_digits(nums):
          pass

      === test_solution.py ===
      from solution import sum_of_digits


      def test_mbpp():
          assert sum_of_digits([10,2,56])==14
          assert sum_of_digits([[10,20,4,5,'b',70,'a']])==19
          assert sum_of_digits([10,20,-4,5,-70])==19

      """

  Scenario: Agent implements sum_of_digits so all pytest tests pass
    Given an agent is tasked with implementing the sum_of_digits function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
