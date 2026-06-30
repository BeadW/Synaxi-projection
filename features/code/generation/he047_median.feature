Feature: HumanEval/47 — implement median
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def median(l: list):
          '''Return median of elements in the list l.
          >>> median([3, 1, 2, 4, 5])
          3
          >>> median([-10, 4, 6, 1000, 10, 20])
          15.0
          '''
          pass

      === test_solution.py ===
      from solution import median


      def test_humaneval():
          assert median([3, 1, 2, 4, 5]) == 3
          assert median([-10, 4, 6, 1000, 10, 20]) == 8.0
          assert median([5]) == 5
          assert median([6, 5]) == 5.5
          assert median([8, 1, 3, 9, 9, 2, 7]) == 7 


      """

  Scenario: Agent implements median so all tests pass
    Given an agent is tasked with implementing the median function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
