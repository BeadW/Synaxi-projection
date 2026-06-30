Feature: HumanEval/3 — implement below_zero
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List


      def below_zero(operations: List[int]) -> bool:
          ''' You're given a list of deposit and withdrawal operations on a bank account that starts with
          zero balance. Your task is to detect if at any point the balance of account fallls below zero, and
          at that point function should return True. Otherwise it should return False.
          >>> below_zero([1, 2, 3])
          False
          >>> below_zero([1, 2, -4, 5])
          True
          '''
          pass

      === test_solution.py ===
      from solution import below_zero


      def test_humaneval():
          assert below_zero([]) == False
          assert below_zero([1, 2, -3, 1, 2, -3]) == False
          assert below_zero([1, 2, -4, 5, 6]) == True
          assert below_zero([1, -1, 2, -2, 5, -5, 4, -4]) == False
          assert below_zero([1, -1, 2, -2, 5, -5, 4, -5]) == True
          assert below_zero([1, -2, 2, -2, 5, -5, 4, -4]) == True

      """

  Scenario: Agent implements below_zero so all tests pass
    Given an agent is tasked with implementing the below_zero function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
