Feature: HumanEval/57 — implement monotonic
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def monotonic(l: list):
          '''Return True is list elements are monotonically increasing or decreasing.
          >>> monotonic([1, 2, 4, 20])
          True
          >>> monotonic([1, 20, 4, 10])
          False
          >>> monotonic([4, 1, 0, -10])
          True
          '''
          pass

      === test_solution.py ===
      from solution import monotonic


      def test_humaneval():
          assert monotonic([1, 2, 4, 10]) == True
          assert monotonic([1, 2, 4, 20]) == True
          assert monotonic([1, 20, 4, 10]) == False
          assert monotonic([4, 1, 0, -10]) == True
          assert monotonic([4, 1, 1, 0]) == True
          assert monotonic([1, 2, 3, 2, 5, 60]) == False
          assert monotonic([1, 2, 3, 4, 5, 60]) == True
          assert monotonic([9, 9, 9, 9]) == True


      """

  Scenario: Agent implements monotonic so all tests pass
    Given an agent is tasked with implementing the monotonic function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
