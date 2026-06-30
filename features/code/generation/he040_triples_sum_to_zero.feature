Feature: HumanEval/40 — implement triples_sum_to_zero
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def triples_sum_to_zero(l: list):
          '''
          triples_sum_to_zero takes a list of integers as an input.
          it returns True if there are three distinct elements in the list that
          sum to zero, and False otherwise.

          >>> triples_sum_to_zero([1, 3, 5, 0])
          False
          >>> triples_sum_to_zero([1, 3, -2, 1])
          True
          >>> triples_sum_to_zero([1, 2, 3, 7])
          False
          >>> triples_sum_to_zero([2, 4, -5, 3, 9, 7])
          True
          >>> triples_sum_to_zero([1])
          False
          '''
          pass

      === test_solution.py ===
      from solution import triples_sum_to_zero


      def test_humaneval():
          assert triples_sum_to_zero([1, 3, 5, 0]) == False
          assert triples_sum_to_zero([1, 3, 5, -1]) == False
          assert triples_sum_to_zero([1, 3, -2, 1]) == True
          assert triples_sum_to_zero([1, 2, 3, 7]) == False
          assert triples_sum_to_zero([1, 2, 5, 7]) == False
          assert triples_sum_to_zero([2, 4, -5, 3, 9, 7]) == True
          assert triples_sum_to_zero([1]) == False
          assert triples_sum_to_zero([1, 3, 5, -100]) == False
          assert triples_sum_to_zero([100, 3, 5, -100]) == False


      """

  Scenario: Agent implements triples_sum_to_zero so all tests pass
    Given an agent is tasked with implementing the triples_sum_to_zero function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
